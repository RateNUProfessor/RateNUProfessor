//
//  ChatScreenViewController.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatScreenViewController: UIViewController {
    
    let chatScreen = ChatScreenView()
    var chatsList = [Chat]()
    var usersDictionary = [String: User]()
    var currentUser:FirebaseAuth.User?
    var otherUser = User(id: "", name: "", email: "", password: "", campus: "")
    let database = Firestore.firestore()
    let childProgressView = ProgressSpinnerViewController()
    override func loadView() {
        view = chatScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Chat"
        
        chatScreen.tableViewChats.delegate = self
        chatScreen.tableViewChats.dataSource = self
        chatScreen.tableViewChats.separatorStyle = .none
        
        currentUser = Auth.auth().currentUser
        chatScreen.labelChat.text = "Welcome \(currentUser?.displayName ?? "Anonymous")!"
        observeCurrentUsers()
        print("In Chat Screen View Controller")
        print(usersDictionary)
    }
    
    func observeCurrentUsers(){
        self.database.collection("users")
            .addSnapshotListener(includeMetadataChanges: false, listener: {
                querySnapshot, error in
                if let documents = querySnapshot?.documents{
                    self.usersDictionary.removeAll()
                    for document in documents{
                        do {
                            let user  = try document.data(as: User.self)
                            self.usersDictionary.updateValue(user, forKey: user.id)
                        }catch{
                            print(error)
                        }
                    }
                    self.observeCurrentChats()
                }
            }
        )
    }
    
    
    func observeCurrentChats(){
        self.database.collection("users")
            .document((self.currentUser?.uid)!)
            .collection("chats")
            .addSnapshotListener(includeMetadataChanges: false, listener:{ querySnapshot, error in
                if let documents = querySnapshot?.documents{
                    self.chatsList.removeAll()
                    for document in documents{
                        do{
                            let chat  = try document.data(as: Chat.self)
                            self.chatsList.append(chat)
                        }catch{
                            print(error)
                        }
                    }
                    self.chatsList.sort(by: {
                        $0.latestTimeStamp! > $1.latestTimeStamp!
                    })
                    self.chatScreen.tableViewChats.reloadData()
                    
                    self.hideActivityIndicator()
                }
            }
        )
    }
    
}
