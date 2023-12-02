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
