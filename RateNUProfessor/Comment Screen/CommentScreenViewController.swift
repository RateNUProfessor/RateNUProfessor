//
//  CommentScreenViewController.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class CommentScreenViewController: UIViewController {

    //TODO: 有关view上的Todo
    //TODO: 在页面上方应该有这个professor的平均分
    //TODO: 每个comment展示的部分可以再改一下
    let commentScreen = CommentScreenView()
    // waiting to get the professor selected from the search screen
    var professorObj = Professor(name: "")
    var allScoresList = [SingleRateUnit]()
    var currentUser:FirebaseAuth.User?
    let database = Firestore.firestore()
        
    override func loadView() {
        view = commentScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = professorObj.name
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //currentUser = Auth.auth().currentUser
        
        database.collection("professors")
            .document(professorObj.professorUID)
            .collection("comments")
            .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
                if let documents = querySnapshot?.documents{
                    self.allScoresList.removeAll()
                    for document in documents{
                        do{
                            let comment  = try document.data(as: SingleRateUnit.self)
                            self.allScoresList.append(comment)
                        }catch{
                            print(error)
                        }
                    }
                        self.allScoresList.sort(by: {$0.rateSemester < $1.rateSemester})
                        self.commentScreen.tableViewComments.reloadData()
                    }
                })
        
        
        // mock data
        // TODO: professor是从search screen传入，确保传入的时候里面是有UID的
        // 我这里在模拟的时候，直接写了一个叫mock professor的UID
        //professorObj.professorUID = "wsxOITjTZc9JZUvWm0IH"
        
        let student = User(id: "1", name: "Livia", email: "1@qq.com", password: "1111", campus: "San Jose")
        
        // TODO: 这里直接用mock data展示了comment，应该从firebase里拿这个professor所有的comments并展示
        var rate1 = SingleRateUnit(commentId: "pg5mNrXQ7MePF1UBT0WM", rateStudent: student, rateProfessor: professorObj, rateClass: "CS5002", rateScore: 4.0, rateComment: "adshfgip3ohfjk23rje2", rateSemester: "23Fall", rateCampus: "San Jose")
        
        var rate2 = SingleRateUnit(commentId: "oC9QpLgkJY2cbh8D0Qer", rateStudent: student, rateProfessor: professorObj, rateClass: "CS5001", rateScore: 3.0, rateComment: "not recommend!", rateSemester: "23Spring", rateCampus: "Boston")


        // let prof = Professor(name: "Jake")
       
        //TODO: 需要notification center, 监听add new comment page新加的comment并reload tableview
        
        allScoresList.append(rate1)
        allScoresList.append(rate2)
        
        
        commentScreen.tableViewComments.delegate = self
        commentScreen.tableViewComments.dataSource = self
        commentScreen.tableViewComments.separatorStyle = .none
        
        commentScreen.floatingButtonAddComment.addTarget(self, action: #selector(onAddCommentButtonTapped), for: .touchUpInside)
    }
    
    @objc func onAddCommentButtonTapped() {
        let addCommentScreenViewController = AddCommentScreenViewController()
        // pass the professor object to Add Comment Screen
        addCommentScreenViewController.professor = professorObj
        navigationController?.pushViewController(addCommentScreenViewController, animated: true)
    }


}
