//
//  ChangePasswordView.swift
//  RateNUProfessor
//
//  Created by ZAN on 1/12/2023.
//

import UIKit

class ChangePasswordView: UIView {
    
    var newPasswordTextField: UITextField!
    var confirmNewPasswordTextField: UITextField!
    var changePasswordButton: UIButton!
    var loadingIndicator: UIActivityIndicatorView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupNewPasswordTextField()
        setupConfirmNewPasswordTextField()
        setupChangePasswordButton()
        setupLoadingIndicator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupNewPasswordTextField() {
        newPasswordTextField = UITextField()
        newPasswordTextField.placeholder = "New Password"
        newPasswordTextField.borderStyle = .roundedRect
        newPasswordTextField.isSecureTextEntry = true
        addSubview(newPasswordTextField)
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            newPasswordTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            newPasswordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            newPasswordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }

    private func setupConfirmNewPasswordTextField() {
        confirmNewPasswordTextField = UITextField()
        confirmNewPasswordTextField.placeholder = "Confirm New Password"
        confirmNewPasswordTextField.borderStyle = .roundedRect
        confirmNewPasswordTextField.isSecureTextEntry = true
        addSubview(confirmNewPasswordTextField)
        confirmNewPasswordTextField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            confirmNewPasswordTextField.topAnchor.constraint(equalTo: newPasswordTextField.bottomAnchor, constant: 10),
            confirmNewPasswordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            confirmNewPasswordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }

    private func setupChangePasswordButton() {
        changePasswordButton = UIButton(type: .system)
        changePasswordButton.setTitle("Confirm", for: .normal)
        addSubview(changePasswordButton)
        changePasswordButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            changePasswordButton.topAnchor.constraint(equalTo: confirmNewPasswordTextField.bottomAnchor, constant: 20),
            changePasswordButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    private func setupLoadingIndicator() {
        loadingIndicator = UIActivityIndicatorView(style: .medium)
        addSubview(loadingIndicator)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
    }
}

