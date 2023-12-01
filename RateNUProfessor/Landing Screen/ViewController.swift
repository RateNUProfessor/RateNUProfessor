//
//  ViewController.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController {
    
    let landingScreen = LandingScreenView()
    var handleAuth: AuthStateDidChangeListenerHandle?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handleAuth = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            guard let self = self else { return }

            if user != nil {
                let topBarVC = TabBarScreenViewController()
                self.navigationController?.pushViewController(topBarVC, animated: true)
            } else {
            }
        }
    }
    
    override func loadView() {
        view = landingScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        landingScreen.buttonSignIn.addTarget(self, action: #selector(onButtonSignInTapped), for: .touchUpInside)
        landingScreen.buttonSignUp.addTarget(self, action: #selector(onButtonSignUpTapped), for: .touchUpInside)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let handleAuth = handleAuth {
            Auth.auth().removeStateDidChangeListener(handleAuth)
        }
    }
    
    
    @objc func onButtonSignInTapped() {
        let loginController = LoginScreenViewController()
        self.navigationController?.pushViewController(loginController, animated: true)
    }
    
    @objc func onButtonSignUpTapped() {
        let signUpController = SignUpScreenViewController()
        self.navigationController?.pushViewController(signUpController, animated: true)
    }
}
