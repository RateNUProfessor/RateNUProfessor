//
//  ViewController.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit

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
        
    }
    
    @objc func onButtonSignInTapped() {
        let loginController = LoginScreenViewController()
        self.navigationController?.pushViewController(loginController, animated: true)
    }


}

