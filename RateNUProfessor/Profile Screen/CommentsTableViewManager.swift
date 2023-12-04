//
//  CommentsTableViewManager.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/29/23.
//

import Foundation
import UIKit
import FirebaseFirestore

extension ProfileScreenViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewProfileCommentID, for: indexPath) as! PostCommentTableViewCell
        cell.labelName.text = comments[indexPath.row].rateProfessor.name
        cell.labelInfo.text = "\(comments[indexPath.row].rateClass), \(comments[indexPath.row].rateCampus), \(comments[indexPath.row].rateSemester)"
        cell.labelComment.text = "\(comments[indexPath.row].rateComment)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){ action, view, completion   in
            
            let alert = UIAlertController(title: "Delete the comment?", message: "Are you sure you want to delete the comment?", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {_ in
                
                //self.deleteANote(token: self.authToken!, id: self.comments[indexPath.row]._id)
                if let id = self.currentUser?.uid {
                    
                    print("delete commet - check commentID")
                    print(self.comments[indexPath.row].commentId)
                   
                    // remove comment from user collection
                    self.database.collection("users")
                        .document(id)
                        .collection("comments")
                        .document(self.comments[indexPath.row].commentId).delete() { err in
                        if let err = err {
                          print("Error removing document: \(err)")
                        } else {
                          print("Document successfully removed from user Collection!")
                        }
                      }
                    
                    self.database.collection("professors")
                        .document(self.comments[indexPath.row].rateProfessor.professorUID)
                        .collection("comments")
                        .document(self.comments[indexPath.row].commentId).delete() { err in
                        if let err = err {
                          print("Error removing document: \(err)")
                        } else {
                          print("Document successfully removed from professor Collection!")
                        }
                      }
                }
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .default))
            self.present(alert, animated: true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
    }
}
