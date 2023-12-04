//
//  CommentScreenViewController.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class CommentScreenViewController: UIViewController {
    
    let commentScreen = CommentScreenView()
    // waiting to get the professor selected from the search screen
    var professorObj = Professor(name: "")
    var allScoresList = [SingleRateUnit]()
    var usersDictionary = [String: User]()
    let notificationCenter = NotificationCenter.default
    var currentUser = FirebaseAuth.Auth.auth().currentUser
        
    override func loadView() {
        view = commentScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        title = professorObj.name        

        navigationController?.navigationBar.prefersLargeTitles = true
        
        commentScreen.tableViewComments.rowHeight = UITableView.automaticDimension
        commentScreen.tableViewComments.estimatedRowHeight = 100
        
        
        commentScreen.tableViewComments.delegate = self
        commentScreen.tableViewComments.dataSource = self
        commentScreen.tableViewComments.separatorStyle = .none
        
        commentScreen.floatingButtonAddComment.addTarget(self, action: #selector(onAddCommentButtonTapped), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCommentsForProfessor()
    }
    
    func fetchCommentsForProfessor() {
        let professorUID = professorObj.professorUID
        
        var totalScore = 0.0
        var numberOfScores = 0
        
        let db = Firestore.firestore()
        db.collection("users").getDocuments { [weak self] (userQuerySnapshot, err) in
            if let err = err {
                print("Error getting users: \(err)")
                return
            }
            
            // clear all the comments
            self?.allScoresList.removeAll()
            
            // track asynchronous operations
            let group = DispatchGroup()

            // loop through all the users
            for userDocument in userQuerySnapshot!.documents {
                group.enter()
                
                let userData = userDocument.data()
                let user = User(
                    id: userDocument.documentID,
                    name: userData["name"] as? String ?? "",
                    email: userData["email"] as? String ?? "",
                    password: userData["password"] as? String ?? "",
                    campus: userData["campus"] as? String ?? ""
                )

                // get the comments for the selected professors
                db.collection("users").document(userDocument.documentID).collection("comments")
                    .whereField("rateProfessor.professorUID", isEqualTo: self?.professorObj.professorUID ?? "")
                    .getDocuments { (commentQuerySnapshot, err) in
                        if let err = err {
                            print("Error getting comments: \(err)")
                            group.leave() // leave group
                            return
                        }

                        // loop through all the comments from the user
                        for commentDocument in commentQuerySnapshot!.documents {
                            let commentData = commentDocument.data()
                            if let rateScore = commentData["rateScore"] as? Double {
                                totalScore += rateScore
                                numberOfScores += 1
                            }
                        
                            let rate = SingleRateUnit(
                                commentId: commentDocument.documentID,
                                rateStudent: user,
                                rateProfessor: self?.professorObj ?? Professor(name: ""),
                                rateClass: commentData["rateClass"] as? String ?? "",
                                rateScore: commentData["rateScore"] as? Double ?? 0.0,
                                rateComment: commentData["rateComment"] as? String ?? "",
                                rateSemester: commentData["rateSemester"] as? String ?? "",
                                rateCampus: commentData["rateCampus"] as? String ?? ""
                            )
                            self?.allScoresList.append(rate)
                        }
                        self?.allScoresList.sort(by: {$0.rateSemester > $1.rateSemester})
                        group.leave() 
                    }
            }
                        
            group.notify(queue: .main) {
                // calcualte the average score
                if numberOfScores > 0 {
                    let averageScore = totalScore / Double(numberOfScores)
                    self?.commentScreen.averageScoreLabel.text = "Average Score: \(String(format: "%.2f", averageScore))"
                    db.collection("professors").document(professorUID).updateData([
                        "avgScore": "\(String(format: "%.2f", averageScore))"
                    ]) { err in
                        if let err = err {
                          print("Error updating document: \(err)")
                        } else {
                          print("Document successfully updated")
                        }
                    }
                } else {
                    self?.commentScreen.averageScoreLabel.text = "No Scores Available"
                }
                self?.commentScreen.tableViewComments.reloadData()
            }

        }
    }
    
    @objc func onAddCommentButtonTapped() {
        let addCommentScreenViewController = AddCommentScreenViewController()
        
        // pass the professor object to Add Comment Screen
        addCommentScreenViewController.professor = professorObj
        
        
        navigationController?.pushViewController(addCommentScreenViewController, animated: true)
    }
    
    @objc func handleNewComment(_ notification: Notification) {
        if let newComment = notification.userInfo?["newComment"] as? SingleRateUnit {
            print("New comment received: \(newComment)")

            // Add the new comment to the list of comments
            allScoresList.append(newComment)

            // Refresh the table view to show the new comment
            commentScreen.tableViewComments.reloadData()
        } else {
            print("Failed to receive new comment")
        }
    }
}

extension CommentScreenViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allScoresList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewCommentsID, for: indexPath) as! CommentTableViewCell
        let curRateItem = allScoresList[indexPath.row]
       
        cell.labelScore.text = "\(curRateItem.rateScore)"
        cell.labelClass.text = "\(curRateItem.rateClass), \(curRateItem.rateSemester)"
        cell.labelComment.text = "\(curRateItem.rateComment)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(
            title: "Want to chat?",
            message: "Do you want to chat with this person to learn more about this comment?",
            preferredStyle: .alert
        )

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let chatAction = UIAlertAction(title: "Confirm", style: .destructive) { _ in
            let otherUser = self.allScoresList[indexPath.row].rateStudent
            if (self.currentUser?.uid != otherUser.id) {
                if let tabBarController = self.tabBarController {
                    let desiredTabIndex = 1
                    if desiredTabIndex >= 0 && desiredTabIndex < tabBarController.viewControllers?.count ?? 0 {
                        tabBarController.selectedIndex = desiredTabIndex
                        if let selectedNavController = tabBarController.selectedViewController as? UINavigationController {
                            let addNewChatController = AddNewChatViewController()
                            if let currentUsernotNil = self.currentUser {
                                let me = User(firebaseUser: currentUsernotNil)
                                addNewChatController.currentChat = Chat(lastMessage: "",
                                                                        userIds: [self.currentUser!.uid, otherUser.id],
                                                                        userEmails: [self.currentUser!.email!, otherUser.email],
                                                                        users: [me, otherUser])
                                addNewChatController.usersDictionary = self.usersDictionary
                                addNewChatController.otherUser = otherUser
                                print("other user: \(otherUser)")
                                selectedNavController.navigationController?.pushViewController(addNewChatController, animated: true)
                            }
                        }
                    }
                }
            } else {
                let errorAlert = UIAlertController(title: "Error", message: "This comment is posted by you.", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(errorAlert, animated: true)
            }
        }

        alertController.addAction(cancelAction)
        alertController.addAction(chatAction)

        present(alertController, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

}
