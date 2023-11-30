//
//  CommentScreenViewController.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit

class CommentScreenViewController: UIViewController {

    //TODO: 有关view上的Todo
    //TODO: 在页面上方应该有这个professor的平均分
    //TODO: 每个comment展示的部分可以再改一下
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
        // TODO: professor是从search screen传入，确保传入的时候里面是有UID的
        // 我这里在模拟的时候，直接写了一个叫mock professor的UID
        professorObj.professorUID = "wsxOITjTZc9JZUvWm0IH"
        
        
        // TODO: 这里直接用mock data展示了comment，应该从firebase里拿这个professor所有的comments并展示
        var rate1 = SingleRateUnit(rateStudent: student, rateProfessor: professorObj, rateClass: "CS5002", rateScore: 4.0, rateComment: "adshfgip3ohfjk23rje2", , rateSemaster: "23Fall", rateCampus: "San Jose")
        
        var rate2 = SingleRateUnit(rateStudent: student, rateProfessor: professorObj, rateClass: "CS5001", rateScore: 3.0, rateComment: "not recommend!", , rateSemaster: "23Spring", rateCampus: "Boston")

        let student = User(id: "1", name: "Livia", email: "1@qq.com", password: "1111", campus: "San Jose")
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
