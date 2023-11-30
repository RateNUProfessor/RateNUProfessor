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
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser:FirebaseAuth.User?
    let database = Firestore.firestore()
    
    override func loadView() {
        view = profileScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
                self.currentUser = nil
                self.profileScreen.profileImage.image = UIImage(systemName: "person.fill")

                self.comments.removeAll()
                self.profileScreen.tableViewComments.reloadData()
                
            }else{
                self.currentUser = user
                self.profileScreen.labelName.text = self.currentUser?.displayName

                if let url = self.currentUser?.photoURL{
                    self.profileScreen.profileImage.loadRemoteImage(from: url)
                }
                
                self.database.collection("users")
                    .document((self.currentUser?.uid)!)
                    .collection("comments")
                    .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
                        if let documents = querySnapshot?.documents{
                            self.comments.removeAll()
                            for document in documents{
                                do{
                                    let comment  = try document.data(as: SingleRateUnit.self)
                                    self.comments.append(comment)
                                }catch{
                                    print(error)
                                }
                            }
                            self.comments.sort(by: {$0.rateSemaster < $1.rateSemaster})
                            self.profileScreen.tableViewComments.reloadData()
                        }
                    })
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Profile"
        
        profileScreen.tableViewComments.delegate = self
        profileScreen.tableViewComments.dataSource = self
        
        profileScreen.tableViewComments.separatorStyle = .none
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gearshape"),
            style: .plain,
            target: self,
            action: #selector(onSettingsBarButtonTapped))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
    
    @objc func onSettingsBarButtonTapped() {
        let settingsController = SettingScreenViewController()
        navigationController?.pushViewController(settingsController, animated: true)
    }
    
}
