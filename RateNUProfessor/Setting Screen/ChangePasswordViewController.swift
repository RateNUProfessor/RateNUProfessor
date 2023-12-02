//
//  ChangePasswordViewController.swift
//  RateNUProfessor
//
//  Created by ZAN on 1/12/2023.
//

import UIKit
import FirebaseAuth

class ChangePasswordViewController: UIViewController {
    
    let changePasswordView = ChangePasswordView()
    var onPasswordChange: ((String) -> Void)?

    override func loadView() {
        view = changePasswordView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Change Password"
        
        changePasswordView.changePasswordButton.addTarget(self, action: #selector(onChangePasswordButtonTapped), for: .touchUpInside)
    }

    @objc private func onChangePasswordButtonTapped() {
        guard let newPassword = changePasswordView.newPasswordTextField.text,
              let confirmPassword = changePasswordView.confirmNewPasswordTextField.text,
              !newPassword.isEmpty else {
            presentErrorAlert(message: "Please enter a new password.")
            return
        }
        
        guard newPassword == confirmPassword else {
            presentErrorAlert(message: "Passwords do not match.")
            return
        }

        // Prompt the user for their current password for reauthentication
        presentReauthenticationAlert { [weak self] currentPassword in
            self?.reauthenticateUser(currentPassword: currentPassword) {
                self?.updatePassword(newPassword: newPassword)
            }
        }
    }

    private func reauthenticateUser(currentPassword: String, completion: @escaping () -> Void) {
        guard let user = Auth.auth().currentUser, let email = user.email else {
            presentErrorAlert(message: "Unable to get user details for reauthentication.")
            return
        }

        let credential = EmailAuthProvider.credential(withEmail: email, password: currentPassword)
        user.reauthenticate(with: credential) { [weak self] _, error in
            if let error = error {
                self?.presentErrorAlert(message: "Reauthentication failed: \(error.localizedDescription)")
            } else {
                completion()
            }
        }
    }

    private func updatePassword(newPassword: String) {
        changePasswordView.loadingIndicator.startAnimating()

        Auth.auth().currentUser?.updatePassword(to: newPassword) { [weak self] error in
            self?.changePasswordView.loadingIndicator.stopAnimating()
            if let error = error {
                self?.presentErrorAlert(message: "Failed to change password: \(error.localizedDescription)")
            } else {
                self?.onPasswordChange?(newPassword)
                self?.showSuccessAndPop()
            }
        }
    }

    private func showSuccessAndPop() {
        let alert = UIAlertController(title: "Success", message: "Password changed successfully", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }

    private func presentReauthenticationAlert(completion: @escaping (String) -> Void) {
        let alert = UIAlertController(title: "Reauthenticate", message: "Enter your current password to continue.", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Current Password"
            textField.isSecureTextEntry = true
        }
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { _ in
            if let currentPassword = alert.textFields?.first?.text {
                completion(currentPassword)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true)
    }

    private func presentErrorAlert(message: String) {
        let errorAlert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(errorAlert, animated: true)
    }
}
