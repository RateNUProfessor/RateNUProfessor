//
//  AddCommentScreenViewController.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit
import FirebaseAuth

class AddCommentScreenViewController: UIViewController {

    let addCommentScreen = AddCommentScreenView()
    
    
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
        
        if let firebaseuser = firebaseAuthUser {
            var user = User(firebaseUser: firebaseuser)
            // if seccessfully have a new comment
            if let newComment = generateNewComment() {
                professor.rateArray.append(newComment)
                // update the professor in the firebase
                updateProfessorInFireBase()
                
                // update user
                user.allComments.append(newComment)
                updateUserInFireBase()
            }
        }
    }
    
    func updateProfessorInFireBase() {
        
    }
    
    func updateUserInFireBase() {
        
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
