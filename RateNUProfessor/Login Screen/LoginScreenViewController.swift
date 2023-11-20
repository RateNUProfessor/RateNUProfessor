//
//  LoginScreenViewController.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit

class LoginScreenViewController: UIViewController {
    
    let loginScreen = LoginScreenView()
    
    override func loadView() {
        view = loginScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Login"
        
        loginScreen.buttonLogin.addTarget(self, action: #selector(onButtonLoginTapped), for: .touchUpInside)

    }
    
    @objc func onButtonLoginTapped() {
        let tabBarController = TabBarScreenViewController()
        self.navigationController?.pushViewController(tabBarController, animated: true)
    }

}
