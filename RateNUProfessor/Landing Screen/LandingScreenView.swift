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
    var labelEmail: UILabel!
    var textFieldEmail: UITextField!
    var labelPassword: UILabel!
    var textFieldPassword: UITextField!
    
    // let buttonColor = UIColor(red: 1, green: 110.0/255.0, blue: 108.0/255.0, alpha: 1.0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupLabelEmail()
        setupLabelPassword()
        setupTextFieldEmail()
        setupTextFieldPassword()
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
        buttonSignUp.setTitle("Don't have an account? Register here!", for: .normal)
        buttonSignUp.setTitleColor(AppColors.buttonColor, for: .normal)
        buttonSignUp.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSignUp)
    }
    
    func setupLabelEmail() {
        labelEmail = UILabel()
        labelEmail.textAlignment = .left
        labelEmail.text = "Email: "
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelEmail)
    }
    
    func setupLabelPassword() {
        labelPassword = UILabel()
        labelPassword.textAlignment = .left
        labelPassword.text = "Password: "
        labelPassword.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelPassword)
    }
    
    func setupTextFieldEmail(){
        textFieldEmail = UITextField()
        textFieldEmail.placeholder = "Email"
        textFieldEmail.borderStyle = .roundedRect
        textFieldEmail.keyboardType = .emailAddress
        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldEmail)
    }
    
    func setupTextFieldPassword(){
        textFieldPassword = UITextField()
        textFieldPassword.placeholder = "Password"
        textFieldPassword.borderStyle = .roundedRect
        textFieldPassword.isSecureTextEntry = true
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldPassword)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            logoImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            logoImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            
            labelEmail.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            labelEmail.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            labelEmail.trailingAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.trailingAnchor),
            
            textFieldEmail.topAnchor.constraint(equalTo: labelEmail.topAnchor),
            textFieldEmail.leadingAnchor.constraint(equalTo: labelEmail.trailingAnchor, constant: -120),
            textFieldEmail.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            textFieldEmail.heightAnchor.constraint(equalTo: labelEmail.heightAnchor),
            textFieldEmail.widthAnchor.constraint(lessThanOrEqualTo: labelEmail.widthAnchor),
            
            labelPassword.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 20),
            labelPassword.leadingAnchor.constraint(equalTo: labelEmail.leadingAnchor),
            labelPassword.trailingAnchor.constraint(equalTo: labelEmail.trailingAnchor),
            
            textFieldPassword.topAnchor.constraint(equalTo: labelPassword.topAnchor),
            textFieldPassword.leadingAnchor.constraint(equalTo: textFieldEmail.leadingAnchor),
            textFieldPassword.trailingAnchor.constraint(equalTo: textFieldEmail.trailingAnchor),
            
            buttonSignIn.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 32),
            buttonSignIn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            buttonSignIn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            buttonSignIn.heightAnchor.constraint(equalToConstant: 50),
            
            buttonSignUp.topAnchor.constraint(equalTo: buttonSignIn.bottomAnchor),
            buttonSignUp.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            buttonSignUp.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            buttonSignUp.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
