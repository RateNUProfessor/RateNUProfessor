//
//  AddNewChatViewController.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 12/2/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class AddNewChatViewController: UIViewController {
    
    let currentUser = FirebaseAuth.Auth.auth().currentUser
    var usersDictionary = [String: User]()
    var otherUser = User(id: "", name: "", email: "", password: "", campus: "")
    var currentChat: Chat?
    let addChatScreen = AddNewChatScreenView()
    var messages = [Message]()
    let database = Firestore.firestore()
    let childProgressView = ProgressSpinnerViewController()
    
    override func loadView() {
        view = addChatScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showActivityIndicator()
        let chatEmails = currentChat?.userEmails
        self.currentChat?.id = Configs.generateChatIDFromEmails(chatEmails!)
        fetchMessagesFromFirestore()
        
        addChatScreen.tableViewMessages.delegate = self
        addChatScreen.tableViewMessages.dataSource = self
        addChatScreen.tableViewMessages.separatorStyle = .none
        
        addChatScreen.buttonSend.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        
        title = otherUser.name
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
    }
    
    @objc func sendMessage(){
        if addChatScreen.textViewMessage.text.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            let momentInTime = Date().timeIntervalSince1970
            print(momentInTime)
            
            if let msgText = addChatScreen.textViewMessage.text,
               let senderEmail = currentUser?.email{
                
                currentChat?.latestTimeStamp = Int64(momentInTime)
                currentChat?.lastMessage = msgText
                
                saveMessageToFirestore(message: Message(
                    msgText: msgText.trimmingCharacters(in: .whitespacesAndNewlines),
                    senderEmail: senderEmail,
                    timestamp: Int64(momentInTime)
                ))
                
                addChatScreen.textViewMessage.text = ""
            }
        }
    }
    
    func scrollToBottom() {
        let lastSection = addChatScreen.tableViewMessages.numberOfSections - 1
        let lastRow = addChatScreen.tableViewMessages.numberOfRows(inSection: lastSection) - 1
        let lastIndexPath = IndexPath(row: lastRow, section: lastSection)
        addChatScreen.tableViewMessages.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
    }
}

extension AddNewChatViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(messages)
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewChatID, for: indexPath) as! ChatTableViewCell
        let message = messages[indexPath.row]
        
        let messageType: MessageType = {
            if message.senderEmail == currentUser?.email{
                return .outgoing
            }
            return .incoming
        }()
        
        cell.configure(with: message.msgText,
                       senderName: messageType == .outgoing ? currentUser!.displayName! : otherUser.name,
                       timestamp: message.timestamp,
                       type: messageType)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
    }
}
