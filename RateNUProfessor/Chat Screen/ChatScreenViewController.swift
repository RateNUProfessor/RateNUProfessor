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
    //var usersDictionary = [String: User]()
    var currentUser:FirebaseAuth.User?
    var otherUser = User(id: "", name: "", email: "", password: "", campus: "")
    let database = Firestore.firestore()
    
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

    }
}
