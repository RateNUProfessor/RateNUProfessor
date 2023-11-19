//
//  SignUpScreenViewController.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit

class SignUpScreenViewController: UIViewController {
    
    let signUpScreen = SignUpScreenView()
    
    override func loadView() {
        view = signUpScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sign Up"

    }

}
