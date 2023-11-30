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

class AddCommentScreenViewController: UIViewController {

    let addCommentScreen = AddCommentScreenView()
    let database = Firestore.firestore()
    
    
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
        
        firebaseAuthUser = Auth.auth().currentUser
        addCommentScreen.buttonAdd.addTarget(self, action: #selector(buttonAddTapped), for: .touchUpInside)
        
    }
    
    @objc func buttonAddTapped() {
        if let firebaseuser = firebaseAuthUser {
            print("buttonAddTapped Triggered")
            var user = User(firebaseUser: firebaseuser)
            // if seccessfully have a new comment
            if let newComment = generateNewComment() {
                professor.rateArray.append(newComment)
                // update the professor in the firebase
                updateProfessorInFirebase(professor: professor, newComment: newComment) { result in
                    switch result {
                    case .success:
                        print("User updated successfully")
                        // update Professor in firebase
                    case .failure(let error):
                        print("Error creating chat: \(error.localizedDescription)")
                    }
                }
                // updateProfessorInFirebase()
                updateUserInFirebase(user: user, newComment: newComment) { result in
                    switch result {
                    case .success:
                        print("User updated successfully")
                        // update Professor in firebase
                    case .failure(let error):
                        print("Error creating chat: \(error.localizedDescription)")
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
    
    func updateUserInFirebase(user: User, newComment: SingleRateUnit, completion: @escaping (Result<Void, Error>) -> Void) {
        print("function updateUserInFirebase triggered")
        do {
            try database.collection("users").document(user.id).collection("comments").addDocument(from: newComment) { error in
                if let error = error {
                    print("Error updating chat object: \(error.localizedDescription)")
                    completion(.failure(error))
                } else {
                    print("User - comment updated in Firebase")
                    // back to professor comment screen
                    self.navigationController?.popViewController(animated: true)
                    // TODO: 用notification center让comment screen update这条新增的comment
                    completion(.success(()))
                }
            }
        } catch {
            print("Error setting data: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }
    
    func generateNewComment() -> SingleRateUnit? {
        // if any required field is nil
        guard let courseNumber = addCommentScreen.textCourseNumber.text,
              let scoreString = addCommentScreen.textScore.text,
              let comment = addCommentScreen.textComment.text,
              let firebaseUser = firebaseAuthUser else {
                    showAlert(text: "Input field is empty", from: self)
                    return nil // Return nil if any required field is nil
        }
        
        if let firebaseuser = firebaseAuthUser {
            if let score = Double(scoreString) {
                let user = User(firebaseUser: firebaseuser)
                let newComment = SingleRateUnit(rateStudent: user, rateProfessor: professor, rateClass: courseNumber, rateScore: score, rateComment: comment)
                return newComment
            } else {
                showAlert(text: "Can't add new comment", from: self)
                return nil
            }
        }
        return nil
    }
}
