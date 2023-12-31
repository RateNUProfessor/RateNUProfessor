//
//  ProfileScreenViewController.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfileScreenViewController: UIViewController {

    let profileScreen = ProfileScreenView()
    var comments = [SingleRateUnit]()
    var currentUser:FirebaseAuth.User?
    let database = Firestore.firestore()
    let notificationCenter = NotificationCenter.default
    
    override func loadView() {
        view = profileScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshProfileData()
    }
    
    func refreshProfileData() {
        currentUser = Auth.auth().currentUser

        // Reload the profile image
        if let url = currentUser?.photoURL {
            self.profileScreen.profileImage.loadRemoteImage(from: url)
        }

        // Fetch the user data from Firestore
        if let id = currentUser?.uid {
            database.collection("users").document(id).getDocument { [weak self] document, error in
                guard let self = self else { return }
                if let error = error {
                    print("Error getting document: \(error)")
                } else if let document = document, document.exists {
                    let campus = document["campus"] as? String ?? "Unknown"
                    self.profileScreen.labelCampus.text = campus
                    // Assuming you are storing the user's name in Firestore as well
                    let name = document["name"] as? String ?? "Unknown"
                    self.profileScreen.labelName.text = name
                } else {
                    print("Document does not exist")
                }
            }
        }
    }

        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Profile"
        
        currentUser = Auth.auth().currentUser
        
        profileScreen.tableViewComments.delegate = self
        profileScreen.tableViewComments.dataSource = self
        
        profileScreen.tableViewComments.separatorStyle = .none
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gearshape"),
            style: .plain,
            target: self,
            action: #selector(onSettingsBarButtonTapped))
        
        profileScreen.labelName.text = currentUser?.displayName
        
        notificationCenter.addObserver(
                    self,
                    selector: #selector(onphotoUpdated(notification:)),
                    name: .photoUpdated, object: nil)
                
        
        if let url = currentUser?.photoURL{
            self.profileScreen.profileImage.loadRemoteImage(from: url)
        }
                
        if let id = currentUser?.uid {
            self.database.collection("users").document(id).getDocument { (document, error) in
                if let error = error {
                    print("Error getting document: \(error)")
                } else if let document = document, document.exists {
                    let campus = document["campus"] as? String ?? "Unknown"
                    self.profileScreen.labelCampus.text = campus
                } else {
                    print("Document does not exist")
                }
            }
        }
 
        if let id = currentUser?.uid {
            print("get All comment from user")
            database.collection("users")
                .document(id)
                .collection("comments")
                .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
                    if let documents = querySnapshot?.documents{
                        self.comments.removeAll()
                        for document in documents{
                            do{
                                var comment  = try document.data(as: SingleRateUnit.self)
                                comment.commentId = document.documentID
                                self.comments.append(comment)
                                print(comment.commentId)
                            }catch{
                                print(error)
                            }
                        }
                        self.comments.sort(by: {$0.rateSemester > $1.rateSemester})
                        self.profileScreen.tableViewComments.reloadData()
                    }
                })
        }
    }
    
    @objc func onSettingsBarButtonTapped() {
        let settingsController = SettingScreenViewController()
        navigationController?.pushViewController(settingsController, animated: true)
    }
    
    // reload the profile photo
    @objc func onphotoUpdated(notification: Notification){
        print("Profile Screen -- Notifiction center triggered")
        currentUser = Auth.auth().currentUser
        if let url = currentUser?.photoURL{
            self.profileScreen.profileImage.loadRemoteImage(from: url)
        }
    }
    
}
