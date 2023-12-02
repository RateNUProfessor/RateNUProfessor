//
//  LoginScreenViewController.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit
import FirebaseAuth

class LoginScreenViewController: UIViewController {
    
    let loginScreen = LoginScreenView()
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser:FirebaseAuth.User?
    
    override func loadView() {
        view = loginScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Login"
    
        loginScreen.buttonLogin.addTarget(self, action: #selector(onButtonLoginTapped), for: .touchUpInside)

    }
    
    @objc func onButtonLoginTapped() {
        if let email = loginScreen.textFieldEmail.text, let password = loginScreen.textFieldPassword.text {
            signInToFirebase(email: email, password: password)
        }
    }

    func signInToFirebase(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password, completion: {(result, error) in
            if error == nil{
                let tabBarController = TabBarScreenViewController()
                self.navigationController?.pushViewController(tabBarController, animated: true)
            }else{
                self.showErrorMessage("User not found or Wrong password. Please try again.")
                
            }
        })
    }
    
    func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: "ERROR", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }

}
