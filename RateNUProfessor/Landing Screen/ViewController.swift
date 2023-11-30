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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func loadView() {
        view = landingScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        landingScreen.buttonSignIn.addTarget(self, action: #selector(onButtonSignInTapped), for: .touchUpInside)
        landingScreen.buttonSignUp.addTarget(self, action: #selector(onButtonSignUpTapped), for: .touchUpInside)
        

        func presentViewControllerA() {
          // call if logged in
        }

        func presentViewControllerB() {
          // call if not logged in
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

