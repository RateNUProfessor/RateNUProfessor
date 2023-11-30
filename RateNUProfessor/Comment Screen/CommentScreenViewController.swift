//
//  CommentScreenViewController.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit

class CommentScreenViewController: UIViewController {

    let commentScreen = CommentScreenView()
    // waiting to get the professor selected from the search screen
    var professorObj = Professor(name: "")
    var allScoresList = [SingleRateUnit]()
        
    override func loadView() {
        view = commentScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "All Rate Scores"
        
        // mock data

        let student = User(id: "1", name: "Livia", email: "1@qq.com", password: "1111", campus: "San Jose")
        let prof = Professor(name: "Jake")
        var rate1 = SingleRateUnit(rateStudent: student, rateProfessor: prof, rateClass: "CS5002", rateScore: 4.0, rateSemaster: "23Fall", rateCampus: "San Jose")
        rate1.rateComment = "adshfgip3ohfjk23rje2"
       
        var rate2 = SingleRateUnit(rateStudent: student, rateProfessor: prof, rateClass: "CS5001", rateScore: 3.0, rateSemaster: "23Spring", rateCampus: "Boston")
        rate2.rateComment = "not recommend!"
        
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
