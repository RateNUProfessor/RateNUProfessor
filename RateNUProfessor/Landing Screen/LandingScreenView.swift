//
//  LandingScreenView.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit

class LandingScreenView: UIView {
    var logoImageView: UIImageView!
    var buttonSignIn: UIButton!
    var buttonSignUp: UIButton!
    
    // let buttonColor = UIColor(red: 1, green: 110.0/255.0, blue: 108.0/255.0, alpha: 1.0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupLogoImageView()
        setupSignInButton()
        setupSignUpButton()
        setupConstraints()
    }
    
    
    func setupLogoImageView() {
        logoImageView = UIImageView()
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.clipsToBounds = true
        logoImageView.image = UIImage(named: "landingImage")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(logoImageView)
    }
    
    func setupSignInButton() {
        buttonSignIn = UIButton(type: .system)
        buttonSignIn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        buttonSignIn.setTitle("Sign In", for: .normal)
        // set the font color as white
        buttonSignIn.setTitleColor(UIColor.white, for: .normal)
        buttonSignIn.backgroundColor = AppColors.buttonColor
        // have rounded corners
        buttonSignIn.layer.cornerRadius = 8
        buttonSignIn.clipsToBounds = true
        buttonSignIn.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSignIn)
    }
    
    func setupSignUpButton() {
        buttonSignUp = UIButton(type: .system)
        buttonSignUp.titleLabel?.font = .boldSystemFont(ofSize: 16)
        buttonSignUp.setTitle("Sign Up", for: .normal)
        // set the font color as white
        buttonSignUp.setTitleColor(UIColor.white, for: .normal)
        buttonSignUp.backgroundColor = AppColors.buttonColor
        // have rounded corners
        buttonSignUp.layer.cornerRadius = 8
        buttonSignUp.clipsToBounds = true
        buttonSignUp.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSignUp)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            logoImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            logoImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            
            buttonSignIn.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            buttonSignIn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            buttonSignIn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            buttonSignIn.heightAnchor.constraint(equalToConstant: 50),
            
            buttonSignUp.topAnchor.constraint(equalTo: buttonSignIn.bottomAnchor, constant: 20), // Adjust top constraint as needed
            buttonSignUp.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20), // Adjust leading constraint as needed
            buttonSignUp.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20), // Adjust trailing constraint as needed
            buttonSignUp.heightAnchor.constraint(equalToConstant: 50) // Adjust height as needed
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
