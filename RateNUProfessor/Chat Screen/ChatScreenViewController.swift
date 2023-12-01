//
//  ChatScreenViewController.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit
import FirebaseAuth
import MessageKit
import FirebaseFirestore

class ChatScreenViewController: UIViewController {
    
    let chatScreen = ChatScreenView()
    
    var messages: [Message] = []
    
    override func loadView() {
        view = chatScreen
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Chat"

    }
}
