//
//  AddCommentScreenViewController.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

//TODO: 增加每一个comment应该fields
// add comment
class AddCommentScreenViewController: UIViewController {

    let addCommentScreen = AddCommentScreenView()
    let database = Firestore.firestore()
//    var selectedCourse = "CS5001"
    var selectedYear = "2023"
    var selectedTerm = "Spring"
    
    // Variables to store user-selected values
    var selectedCourse = ""
//    var selectedYear = ""
//    var selectedTerm = ""
    var years = [String]()
    
    // receive the professor object from the All Comment Screen
    var professor = Professor(name: "")
    var firebaseAuthUser:FirebaseAuth.User?

    override func loadView() {
        view = addCommentScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = professor.name
        
        getYearData()
        
        addCommentScreen.pickerYear.dataSource = self
        addCommentScreen.pickerYear.delegate = self
        addCommentScreen.pickerTerm.dataSource = self
        addCommentScreen.pickerTerm.delegate = self
        
        firebaseAuthUser = Auth.auth().currentUser
        addCommentScreen.buttonAdd.addTarget(self, action: #selector(buttonAddTapped), for: .touchUpInside)
        addCommentScreen.buttonCourseNumber.menu = getMenuCourses()

    }
    
    func getMenuCourses() -> UIMenu {
        var menuItems = [UIAction]()
        
        // Fetch courses from Firestore
        database.collection("courses").getDocuments { [weak self] (querySnapshot, err) in
            guard let self = self else { return }

            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    // Assuming each document has an "id" field with the course ID
                    if let courseID = document.data()["id"] as? String {
                        let menuItem = UIAction(title: courseID, handler: { _ in
                            self.selectedCourse = courseID
                            self.addCommentScreen.buttonCourseNumber.setTitle(courseID, for: .normal)
                        })
                        menuItems.append(menuItem)
                    }
                }
            }

            let menu = UIMenu(title: "Select course", children: menuItems)
            DispatchQueue.main.async {
                self.addCommentScreen.buttonCourseNumber.menu = menu
            }
        }
        
        return UIMenu(title: "Loading courses...", children: [])
    }

    func getYearData() {
        var currentYear = Calendar.current.component(.year, from: Date())
        for year in (currentYear - 5)...(currentYear + 5) {
            years.append("\(year)")
        }
    }
    
    @objc func buttonAddTapped() {
        print("buttonAddTapped called line 85")
        
        guard let firebaseuser = firebaseAuthUser else {
            print("No Firebase user found")
            return
        }
        
        if let newComment = generateNewComment() {
            // if successfully have a new comment
            print("New comment generated")
            
            // Sequentially updating professor and user in Firebase
            let dispatchGroup = DispatchGroup()
            
            dispatchGroup.enter()
            updateCourseNumberInFirebase(professor: professor) { result in
                switch result {
                case .success:
                    print("Link professor with courseNumber successfully")
                case .failure(let error):
                    print("Error linking professor with courseID: \(error.localizedDescription)")
                }
                dispatchGroup.leave()
            }

            dispatchGroup.enter()
            updateProfessorInFirebase(professor: professor, newComment: newComment) { result in
                switch result {
                case .success(let documentID):
                    print("Professor updated successfully")
                    // Recalculate professor's score if needed
                    // recalculateProfessorScore(professorUID: professor.professorUID)
                    // get the documentID generated
                    print(documentID)
                    self.updateUserInFirebase(user: User(firebaseUser: firebaseuser), newComment: newComment, commentID: documentID) { result in
                        switch result {
                        case .success:
                            print("User updated successfully")
                        case .failure(let error):
                            print("Error update user: \(error.localizedDescription)")
                        }
                    }
                case .failure(let error):
                    print("Error update professor: \(error.localizedDescription)")
                }
                dispatchGroup.leave()
            }

//            dispatchGroup.enter()
//            updateUserInFirebase(user: User(firebaseUser: firebaseuser), newComment: newComment, commentID: commentID) { result in
//                switch result {
//                case .success:
//                    print("User updated successfully")
//                case .failure(let error):
//                    print("Error update user: \(error.localizedDescription)")
//                }
//                dispatchGroup.leave()
//            }

            dispatchGroup.notify(queue: .main) {
                // All Firebase updates are done here
                // Notify other parts of the app that a new comment has been added
//                NotificationCenter.default.post(name: NSNotification.Name("NewCommentAdded"), object: nil, userInfo: ["newComment": newComment])
                
                // Pop the current view controller
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            print("Failed to generate new comment")
        }
    }

    
    func generateNewComment() -> SingleRateUnit? {
        // Ensure required fields are not empty and score is a valid number
        guard let scoreString = addCommentScreen.textScore.text,
              let comment = addCommentScreen.textComment.text,
              let score = Double(scoreString),
              !selectedCourse.isEmpty,
              !selectedYear.isEmpty,
              !selectedTerm.isEmpty,
              let firebaseuser = firebaseAuthUser else {
            showAlert(text: "Input field is empty or invalid", from: self)
            return nil
        }
        
        let user = User(firebaseUser: firebaseuser)
        let semester = "\(selectedYear) \(selectedTerm)"
        let newComment = SingleRateUnit(commentId: "", rateStudent: user, rateProfessor: professor, rateClass: selectedCourse, rateScore: score, rateComment: comment, rateSemester: semester, rateCampus: "Boston")
        return newComment
    }
    
    
    func updateProfessorInFirebase(professor: Professor, newComment: SingleRateUnit, completion: @escaping (Result<String, Error>) -> Void) {
        print("function updateProfessorInFirebase triggered")
        do {
            let dbCommentRef = database.collection("professors").document(professor.professorUID).collection("comments")
            var newDocumentRef: DocumentReference?
            newDocumentRef = try dbCommentRef.addDocument(from: newComment) { error in
                if let error = error {
                    print("Error updating chat object: \(error.localizedDescription)")
                    completion(.failure(error))
                } else {
                    print("Professor - comment updated in Firebase")
                    if let documentID = newDocumentRef?.documentID {
                        dbCommentRef.document(documentID).updateData([
                            "commentId": documentID
                        ])
                        completion(.success(documentID))
                        // print(documentID)
                    }
                }
            }
        } catch {
            print("Error setting data: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }


    
    // function to linke the courseNumber with the professor firebase reference
    func updateCourseNumberInFirebase(professor: Professor, completion: @escaping (Result<Void, Error>) -> Void) {
        //TODO: 在真正link前需要看一下是否已经关联过，不确定如果已经有这个documentID的话firebase会报错还是当作无事发生
        let profRef = database.collection("professors").document(professor.professorUID)
        if let courseNumber = addCommentScreen.buttonCourseNumber.titleLabel?.text {
            do {
                try database.collection("courses").document(courseNumber).collection("professor").document(professor.professorUID).setData(["profReference": profRef]) { error in
                    if let error = error {
                        print("Error linking professor with courseNumber: \(error.localizedDescription)")
                        completion(.failure(error))
                    } else {
                        print("Link Professor with CourseNumber succeed in Firebase")
                        completion(.success(()))
                    }
                }
            } catch {
                print("Error setting data: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    func updateUserInFirebase(user: User, newComment: SingleRateUnit, commentID: String, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            let dbRef = database.collection("users").document(user.id).collection("comments").document(commentID)
            try dbRef.setData(from: newComment) { error in
                if let error = error {
                    print("Error updating user comment: \(error.localizedDescription)")
                    completion(.failure(error))
                } else {
                    print("User comment updated in Firebase")
                    //set the commentId field
                    dbRef.updateData([
                        "commentId": commentID
                    ])
                    completion(.success(()))

                    // Correctly placed notification
//                    NotificationCenter.default.post(name: NSNotification.Name("NewCommentAdded"), object: nil, userInfo: ["newComment": newComment])
                }
            }
        } catch {
            print("Error setting data: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }




    
    func ifProfessorAlreadyLinked() {
        
    }
    

}

