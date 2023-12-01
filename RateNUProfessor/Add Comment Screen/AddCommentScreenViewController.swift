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
class AddCommentScreenViewController: UIViewController {

    let addCommentScreen = AddCommentScreenView()
    let database = Firestore.firestore()
    var selectedCourse = "CS5001"
    var selectedYear = "2023"
    var selectedTerm = "Spring"
    
    
    // receive the professor object from the All Comment Screen
    var professor = Professor(name: "")
    var firebaseAuthUser:FirebaseAuth.User?
    

    override func loadView() {
        view = addCommentScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Add Comment Screen"
        
        addCommentScreen.pickerYear.dataSource = self
        addCommentScreen.pickerYear.delegate = self
        addCommentScreen.pickerTerm.dataSource = self
        addCommentScreen.pickerTerm.delegate = self
        
        firebaseAuthUser = Auth.auth().currentUser
        addCommentScreen.buttonAdd.addTarget(self, action: #selector(buttonAddTapped), for: .touchUpInside)
        addCommentScreen.buttonCourseNumber.menu = getMenuCourses()
    }
    
    func getMenuCourses() -> UIMenu{
        var menuItems = [UIAction]()
        var courseNumberDatabase = [String]()
        
        database.collection("courses").getDocuments { [weak self] (querySnapshot, err) in
            guard let self = self else { return }

            if let err = err {
                print("Error getting documents: \(err)")
                return
            } else {
                for document in querySnapshot!.documents {
                    let courseID = document.data()["id"] as? String ?? "Unknown ID"
                    let course = Course(courseID: courseID)
                    
                    courseNumberDatabase.append(course.courseID)
                }
                
                for course in courseNumberDatabase {
                    let menuItem = UIAction(title: course,handler: {(_) in
                                        self.selectedCourse = course
                                        self.addCommentScreen.buttonCourseNumber.setTitle(self.selectedCourse, for: .normal)
                                    })
                    menuItems.append(menuItem)
                }
            }
        }
        return UIMenu(title: "Select course", children: menuItems)

    }
    

    
    @objc func buttonAddTapped() {
        if let firebaseuser = firebaseAuthUser {
            print("buttonAddTapped Triggered")
            var user = User(firebaseUser: firebaseuser)
            // if seccessfully have a new comment
            if let newComment = generateNewComment() {
                // link the course with professor
                updateCourseNumberInFirebase(professor: professor) { result in
                    switch result {
                    case .success:
                        print("Link professor with courseNumber successfully")
                    case .failure(let error):
                        print("Error linking professor with courseID: \(error.localizedDescription)")
                    }
                }
                // update the professor in the firebase
                updateProfessorInFirebase(professor: professor, newComment: newComment) { result in
                    switch result {
                    case .success:
                        print("Professor updated successfully")
                        // TODO: 将comment更新后应该重新计算教授的总体score并更新
                        // update Professor in firebase
                    case .failure(let error):
                        print("Error update professor: \(error.localizedDescription)")
                    }
                }
                // update the user in firebase
                updateUserInFirebase(user: user, newComment: newComment) { result in
                    switch result {
                    case .success:
                        print("User updated successfully")
                        // back to professor comment screen
                        self.navigationController?.popViewController(animated: true)
                        // TODO: 用notification center让comment screen update这条新增的comment
                    case .failure(let error):
                        print("Error update user: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    func updateProfessorInFirebase(professor: Professor, newComment: SingleRateUnit, completion: @escaping (Result<Void, Error>) -> Void) {
        print("function updateProfessorInFirebase triggered")
        do {
            try database.collection("professors").document(professor.professorUID).collection("comments").addDocument(from: newComment) { error in
                if let error = error {
                    print("Error updating chat object: \(error.localizedDescription)")
                    completion(.failure(error))
                } else {
                    print("Professor - comment updated in Firebase")
                    completion(.success(()))
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
    
    func updateUserInFirebase(user: User, newComment: SingleRateUnit, completion: @escaping (Result<Void, Error>) -> Void) {
        print("function updateUserInFirebase triggered")
        do {
            try database.collection("users").document(user.id).collection("comments").addDocument(from: newComment) { error in
                if let error = error {
                    print("Error updating chat object: \(error.localizedDescription)")
                    completion(.failure(error))
                } else {
                    print("User - comment updated in Firebase")
                    completion(.success(()))
                }
            }
        } catch {
            print("Error setting data: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }

    
    func ifProfessorAlreadyLinked() {
        
    }
    
    func generateNewComment() -> SingleRateUnit? {
        // if any required field is nil
        guard let courseNumber = addCommentScreen.buttonCourseNumber.titleLabel?.text,
              let scoreString = addCommentScreen.textScore.text,
              let comment = addCommentScreen.textComment.text,
              let firebaseUser = firebaseAuthUser else {
                    showAlert(text: "Input field is empty", from: self)
                    return nil // Return nil if any required field is nil
        }
        
        if let firebaseuser = firebaseAuthUser {
            if let score = Double(scoreString) {
                let user = User(firebaseUser: firebaseuser)
                // TODO: get semaster and campus info from view screen
                let newComment = SingleRateUnit(commentId: "", rateStudent: user, rateProfessor: professor, rateClass: courseNumber, rateScore: score, rateComment: comment, rateSemester: "Fall23", rateCampus: "Boston")
                return newComment
            } else {
                showAlert(text: "Can't add new comment", from: self)
                return nil
            }
        }
        return nil
    }
}
