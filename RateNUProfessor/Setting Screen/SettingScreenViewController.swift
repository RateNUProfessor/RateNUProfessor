//
//  SettingScreenViewController.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class SettingScreenViewController: UIViewController {

    let settingsScreen = SettingScreenView()
    var selectedCampus = "San Jose, CA"
    var currentUser:FirebaseAuth.User?
    let database = Firestore.firestore()
    var loadingIndicator: UIActivityIndicatorView?
    //let changePasswordView = ChangePasswordView()
    var onPasswordChange: ((String) -> Void)?
    
    override func loadView() {
        view = settingsScreen
        
        settingsScreen.buttonCampus.menu = getCampusMenu()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Settings"
        
        showLoadingIndicator()
        
        currentUser = Auth.auth().currentUser
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Logout",
            style: .plain,
            target: self,
            action: #selector(onLogOutBarButtonTapped))
        
        settingsScreen.buttonSave.addTarget(self, action: #selector(onButtonSaveTapped), for: .touchUpInside)
        settingsScreen.buttonChangePwd.addTarget(self, action: #selector(onChangePasswordButtonTapped), for: .touchUpInside)
        
        if let url = currentUser?.photoURL, let name = currentUser?.displayName {
            self.settingsScreen.profileImage.loadRemoteImage(from: url)
            self.settingsScreen.textFieldName.text = name
        }
        
        if let id = currentUser?.uid {
            self.database.collection("users").document(id).getDocument { (document, error) in
                if let error = error {
                    print("Error getting document: \(error)")
                } else if let document = document, document.exists {
                    self.selectedCampus = document["campus"] as? String ?? "Unknown"
                    self.settingsScreen.buttonCampus.setTitle(self.selectedCampus, for: .normal)
                } else {
                    print("Document does not exist")
                }
            }
        }
        fetchUserData()
    }
    
    @objc func onChangePasswordButtonTapped() {
//        let changePasswordVC = ChangePasswordViewController()
        onPasswordChange = { [weak self] newPassword in
            self?.updatePasswordInDatabase(newPassword)
        }
//        navigationController?.pushViewController(changePasswordVC, animated: true)
        
        
        let changePwdAlert = UIAlertController(
            title: "Change Password?",
            message: "Please enter a new password.",
            preferredStyle: .alert)
        
        changePwdAlert.addTextField{ textField in
            textField.placeholder = "New Password"
            textField.contentMode = .center
        }
   
        changePwdAlert.addTextField{ textField in
            textField.placeholder = "Confirm New Password"
            textField.contentMode = .center
            textField.isSecureTextEntry = true
        }

        let changePwdAction = UIAlertAction(title: "Change Password", style: .default, handler: {(_) in
            
            guard let newPassword = changePwdAlert.textFields![0].text,
                  let confirmPassword = changePwdAlert.textFields![1].text,
                  !newPassword.isEmpty else {
                      self.presentErrorAlert(message: "Please enter a new password.")
                return
            }
            
            guard newPassword == confirmPassword else {
                self.presentErrorAlert(message: "Passwords do not match.")
                return
            }

            // Prompt the user for their current password for reauthentication
            self.presentReauthenticationAlert { [weak self] currentPassword in
                self?.reauthenticateUser(currentPassword: currentPassword) {
                    self?.updatePassword(newPassword: newPassword)
                }
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {(_) in
            changePwdAlert.view.superview?.addGestureRecognizer(
                UITapGestureRecognizer(target: self, action: #selector(self.onTapOutsideAlert))
            )
        })
        
        changePwdAlert.addAction(changePwdAction)
        changePwdAlert.addAction(cancelAction)
        
        self.present(changePwdAlert, animated: true, completion: {() in
            changePwdAlert.view.superview?.isUserInteractionEnabled = true
            changePwdAlert.view.superview?.addGestureRecognizer(
                UITapGestureRecognizer(target: self, action: #selector(self.onTapOutsideAlert))
            )
        })
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
        //changePasswordView.loadingIndicator.startAnimating()

        Auth.auth().currentUser?.updatePassword(to: newPassword) { [weak self] error in
            //self?.changePasswordView.loadingIndicator.stopAnimating()
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
    
    @objc func onTapOutsideAlert(){
        self.dismiss(animated: true)
    }

    func updatePasswordInDatabase(_ newPassword: String) {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }

        let db = Firestore.firestore()
        let userDocument = db.collection("users").document(userID)
        userDocument.updateData(["password": newPassword]) { error in
            if let error = error {
                print("Error updating password in Firestore: \(error.localizedDescription)")
            } else {
                print("Password updated in Firestore successfully")
            }
        }
    }
    
    private func fetchUserData() {
        if let id = currentUser?.uid {
            self.database.collection("users").document(id).getDocument { (document, error) in
                // Stop loading indicator
                self.hideLoadingIndicator()

                if let error = error {
                    self.presentErrorAlert(message: "Error getting user data: \(error.localizedDescription)")
                    return
                }

                if let document = document, document.exists {
                    let name = document["name"] as? String ?? "Unknown"
                    let campus = document["campus"] as? String ?? "Unknown"

                    self.settingsScreen.textFieldName.text = name
                    self.selectedCampus = campus
                    self.settingsScreen.buttonCampus.setTitle(self.selectedCampus, for: .normal)
                } else {
                    self.presentErrorAlert(message: "User data not found.")
                }
            }
        } else {
            hideLoadingIndicator()
            presentErrorAlert(message: "User not logged in.")
        }
    }

    
    private func showLoadingIndicator() {
        loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator?.center = self.view.center
        self.view.addSubview(loadingIndicator!)
        loadingIndicator?.startAnimating()
    }

    private func hideLoadingIndicator() {
        loadingIndicator?.stopAnimating()
        loadingIndicator?.removeFromSuperview()
    }

    private func presentErrorAlert(message: String) {
        let errorAlert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(errorAlert, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    @objc func onLogOutBarButtonTapped() {
        let logoutAlert = UIAlertController(title: "Logging out", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        
        logoutAlert.addAction(UIAlertAction(title: "Yes, log out", style: .destructive, handler: { _ in
            do {
                try Auth.auth().signOut()
                // Navigate back to the specific ViewController
                if let viewControllers = self.navigationController?.viewControllers {
                    for viewController in viewControllers {
                        if viewController is ViewController { // Replace 'ViewController' with the actual class name
                            self.navigationController?.popToViewController(viewController, animated: true)
                            return
                        }
                    }
                }
            } catch {
                self.presentErrorAlert()
            }
        }))
        
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        self.present(logoutAlert, animated: true)
    }

    
    private func presentErrorAlert() {
        let errorAlert = UIAlertController(title: "Error", message: "An error occurred while trying to log out. Please try again.", preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(errorAlert, animated: true)
    }
    
    @objc func onButtonSaveTapped() {
        let name = settingsScreen.textFieldName.text
        let campus = selectedCampus

        if let id = currentUser?.uid {
            database.collection("users").document(id).updateData([
                "name": name,
                "campus": campus
            ]) { [weak self] err in
                if let err = err {
                    print("Error updating document: \(err)")
                    self?.presentErrorAlert(message: "Failed to save data: \(err.localizedDescription)")
                } else {
                    print("Document successfully updated")
                    // Pop back to the previous view controller
                    self?.navigationController?.popViewController(animated: true)
                }
            }
        }
    }

    
    func getCampusMenu() -> UIMenu{
        var menuItems = [UIAction]()
        
        for type in Campus.campus{
            let menuItem = UIAction(title: type,handler: {(_) in
                                self.selectedCampus = type
                                self.settingsScreen.buttonCampus.setTitle(self.selectedCampus, for: .normal)
                            })
            menuItems.append(menuItem)
        }
        
        return UIMenu(title: "Select campus", children: menuItems)
    }
}
