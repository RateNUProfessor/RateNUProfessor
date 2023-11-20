//
//  SignUpScreenViewController.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit

class SignUpScreenViewController: UIViewController {
    
    let signUpScreen = SignUpScreenView()
    let childProgressView = ProgressSpinnerViewController()
    
    override func loadView() {
        view = signUpScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sign Up"
        
        signUpScreen.buttonRegister.addTarget(self, action: #selector(onButtonRegisterTapped), for: .touchUpInside)

    }
    
    @objc func onButtonRegisterTapped() {
        registerNewAccount()

        let tabBarController = TabBarScreenViewController()
        self.navigationController?.pushViewController(tabBarController, animated: true)
    }

}
