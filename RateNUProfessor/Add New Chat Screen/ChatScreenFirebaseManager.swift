//
//  ChatScreenFirebaseManager.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 12/2/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

extension AddNewChatViewController{
    func fetchMessagesFromFirestore() {
        print(currentChat?.id)
        if let currentChatId = currentChat?.id{
            let documentCurrentChat = self.database.collection("chats")
                .document(currentChatId)
            
            documentCurrentChat.collection("messages")
                .addSnapshotListener(includeMetadataChanges: false, listener: {
                    querySnapshot, error in
                    if error == nil{
                        if let documents = querySnapshot?.documents{
                            self.messages.removeAll()
                            for document in documents{
                                do {
                                    let msg  = try document.data(as: Message.self)
                                    self.messages.append(msg)
                                    
                                }catch{
                                    print(error)
                                }
                            }
                            
                            self.messages.sort(by: {
                                $0.timestamp < $1.timestamp
                            })
                            
                            self.addChatScreen.tableViewMessages.reloadData()
                            if !self.messages.isEmpty {
                                self.scrollToBottom()
                            }
                            print("Current messages: \(self.messages)")
                        }
                    }else{
                        
                    }
                    self.hideActivityIndicator()
                }
                )
        }
    }
    
    func saveMessageToFirestore(message: Message){
        
        if let userEmails = currentChat?.userEmails,let userIds = currentChat?.userIds {
            let chatID = Configs.generateChatIDFromEmails(userEmails)
            
            let collectionMessages = database
                .collection("chats")
                .document(chatID)
                .collection("messages")

            showActivityIndicator()
            
            do{
                try collectionMessages.addDocument(from: message, completion: {(error) in
                    if error == nil{
                        
                        // set the chat fields
                        self.database.collection("chats").document(chatID).setData(["userIDs": userIds])
                        
                        //update chat references inside users collection...
                        let collectionUsers = self.database
                            .collection("users")
                        
                        for id in userIds{
                            do{
                                try collectionUsers
                                    .document(id)
                                    .collection("chats")
                                    .document(chatID)
                                    .setData(from: self.currentChat, completion: {(error) in
                                        
                                        if error != nil{
                                            Configs.showErrorAlert(message: error?.localizedDescription ?? "Error occured!", viewController: self)
                                        }
                                        
                                    })
                            }catch{
                                print("Error creating message!")
                            }
                            
                        }
                        
                        self.hideActivityIndicator()
                    }else{
                        Configs.showErrorAlert(message: error?.localizedDescription ?? "Error occured!", viewController: self)
                    }
                })
            }catch{
                print("Error creating message!")
            }
        }
    }
}

