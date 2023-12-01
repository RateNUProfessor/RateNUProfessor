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
    
    override func loadView() {
        view = settingsScreen
        
        settingsScreen.buttonCampus.menu = getCampusMenu()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Settings"
        
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    @objc func onLogOutBarButtonTapped(){
        let logoutAlert = UIAlertController(title: "Logging out!", message: "Are you sure want to log out?",
            preferredStyle: .actionSheet)
        logoutAlert.addAction(UIAlertAction(title: "Yes, log out!", style: .default, handler: {(_) in
                do{
                    try Auth.auth().signOut()
                    self.navigationController?.popToRootViewController(animated: true)
                }catch{
                    print("Error occured!")
                }
            })
        )
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(logoutAlert, animated: true)
    }
    
    @objc func onButtonSaveTapped() {
        let name = settingsScreen.textFieldName.text
        let campus = selectedCampus
        if let id = currentUser?.uid {
            database.collection("users").document(id).updateData([
                "name": name,
                "campus": selectedCampus
              ]) { err in
                if let err = err {
                  print("Error updating document: \(err)")
                } else {
                  print("Document successfully updated")
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
