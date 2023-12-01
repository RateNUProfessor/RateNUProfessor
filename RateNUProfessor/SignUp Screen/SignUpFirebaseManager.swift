//
//  SignUpFirebaseManager.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/19/23.
//

import UIKit
import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

extension SignUpScreenViewController{
    
    func registerNewAccount(photoURL: URL?){
        let name = signUpScreen.textFieldName.text
        let email = signUpScreen.textFieldEmail.text
        let password = signUpScreen.textFieldPassword.text
        let repeatPwd = signUpScreen.textFieldRepeatPassword.text
        
        if let uwName = name, let uwEmail = email, let uwPassword = password, let uwRepeatPwd = repeatPwd {
            
            if (uwName.isEmpty || uwEmail.isEmpty || uwPassword.isEmpty || uwRepeatPwd.isEmpty) {
                showErrorMessage("Text Field can not be empty")
                return // once a condition is not met, we end this function
            }
            if (!isValidEmail(uwEmail)) {
                showErrorMessage("Email Address is invalid. Please try again!")
                return
            }
            if (uwPassword != uwRepeatPwd) {
                showErrorMessage("Repeat password does not match. Please try again!")
                return
            }
            if (uwPassword.count < 6) {
                showErrorMessage("Password must be at least 6 characters long.")
                return
            }
            
            showActivityIndicator()
            Auth.auth().createUser(withEmail: uwEmail, password: uwPassword, completion: {result, error in
                if error == nil{
                    self.setNameAndPhotoOfTheUserInFirebaseAuth(name: uwName, email: uwEmail, photoURL: photoURL)
                    
                    let uid = Auth.auth().currentUser?.uid // Note the newly created user is the current user
                    var user = User(id: uid!, name: uwName, email: uwEmail, password: uwPassword, campus: self.selectedCampus)
                    self.saveUserToFireStore(user)
                }else{
                    self.hideActivityIndicator()
                    // do not display all the error message to the user. They dislike it
                    self.showErrorMessage("Error: Failed to register")
                }
            })
            
        }
    }
    
    func uploadProfilePhotoToStorage(){
        var profilePhotoURL:URL?
        
        if let image = pickedImage{
            if let jpegData = image.jpegData(compressionQuality: 80){
                let storageRef = storage.reference()
                let imagesRepo = storageRef.child("imagesUsers")
                let imageRef = imagesRepo.child("\(NSUUID().uuidString).jpg")
                
                let uploadTask = imageRef.putData(jpegData, completion: {(metadata, error) in
                    if error == nil{
                        imageRef.downloadURL(completion: {(url, error) in
                            if error == nil{
                                profilePhotoURL = url
                                self.registerNewAccount(photoURL: profilePhotoURL)
                            }
                        })
                    } else {
                        self.hideActivityIndicator()
                    }
                })
            }
        }else{
            registerNewAccount(photoURL: profilePhotoURL)
        }
    }
    
    func setNameAndPhotoOfTheUserInFirebaseAuth(name: String, email: String, photoURL: URL?){
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.photoURL = photoURL
        
        changeRequest?.commitChanges(completion: {(error) in
            self.hideActivityIndicator()
            if error != nil {
                print("Error occured: \(String(describing: error))")
            }
        })
    }
    
    func saveUserToFireStore(_ user: User){
        let database = Firestore.firestore()
        let collectionUsers = database
                .collection("users")
                .document(user.id)
        collectionUsers.setData([
            "uid": user.id,
            "name": user.name,
            "email": user.email,
            "campus": user.campus
        ]){(error) in
            self.hideActivityIndicator()
            if error == nil{
                print("DEBUG: New user saved to FireStore.")
            } else {
                print("DEBUG: New user failed to be saved to FireStore")
            }
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: "ERROR", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    

}
