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
                showEmptyError()
            }
            if (!isValidEmail(uwEmail)) {
                showEmailError()
            }
            if (uwPassword != uwRepeatPwd) {
                showWrongPasswordError()
            }
            if (uwPassword.count < 6) {
                showErrorMessage("Password must be at least 6 characters long.")
            }
            
            if (!uwName.isEmpty && !uwEmail.isEmpty && !uwPassword.isEmpty && !uwRepeatPwd.isEmpty && isValidEmail(uwEmail) && uwPassword == uwRepeatPwd && uwPassword.count >= 6) {
                showActivityIndicator()
                Auth.auth().createUser(withEmail: uwEmail, password: uwPassword, completion: {result, error in
                    if error == nil{
                        self.setNameAndPhotoOfTheUserInFirebaseAuth(name: uwName, email: uwEmail, photoURL: photoURL)
                        let uid = Auth.auth().currentUser?.uid
                        var user = User(id: uid!, name: uwName, email: uwEmail, password: uwPassword, campus: self.selectedCampus)
                        self.saveUserToFireStore(user)
                    }else{
                        if let uwError = error {
                            self.showErrorMessage((String(describing: uwError)))
                        }
                    }
                })
            }
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
            if error != nil{
                print("Error occured: \(String(describing: error))")
            }else{
                self.hideActivityIndicator()
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
            if error == nil{
                print(error)
            } else {
                print("New user saved.")
            }
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func showEmptyError() {
        let alert = UIAlertController(title: "ERROR", message: "Text Field can not be empty", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    func showEmailError() {
        let alert = UIAlertController(title: "ERROR", message: "Email Address is invalid. Please try again!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    func showWrongPasswordError() {
        let alert = UIAlertController(title: "ERROR", message: "Repeat password does not match. Please try again!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: "ERROR", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    

}
