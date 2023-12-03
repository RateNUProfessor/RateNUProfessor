//
//  ChatsTableViewManager.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 12/2/23.
//

import Foundation

import UIKit

extension ChatScreenViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if chatsList.count == 0 {
            let cell = UITableViewCell()
            cell.textLabel?.text = "No chat found."
            cell.textLabel?.textAlignment = .center
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewChatsID, for: indexPath) as! ChatsTableViewCell
            let chat = chatsList[indexPath.row]
            let userEmails = chat.userEmails
            
            cell.labelName.text = otherUser.name
            
            cell.lastMessage.text = chat.lastMessage
            cell.timeStamp.text = Configs.getRelativeDate(chatsList[indexPath.row].latestTimeStamp!)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newChatController = AddNewChatViewController()
        newChatController.currentChat = chatsList[indexPath.row]
        newChatController.otherUser = self.otherUser
        newChatController.usersDictionary = self.usersDictionary
        navigationController?.pushViewController(newChatController, animated: true)
    }
}
