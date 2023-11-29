//
//  SearchScreenViewController.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit

class SearchScreenViewController: UIViewController {
    
    let searchScreen = SearchScreenView()
    let notificationCenter = NotificationCenter.default
    
    let searchProfessorSheetController = SearchProfessorBottomSheetController()
    let searchCourseNumberSheetController = SearchCourseNumberBottomSheetController()
    var searchSheetNavController: UINavigationController!
    
    override func loadView() {
        view = searchScreen
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Search"
        
        searchScreen.searchByProfessorButton.addTarget(self, action: #selector(onSearchByProfessorButtonTapped), for: .touchUpInside)
        searchScreen.searchByCourseNumberButton.addTarget(self, action: #selector(onSearchByCourseNumberButtonTapped), for: .touchUpInside)
        
        notificationCenter.addObserver(
                    self,
                    selector: #selector(onProfessorSelected(notification:)),
                    name: .professorSelected, object: nil)
        
        notificationCenter.addObserver(
                    self,
                    selector: #selector(onCourseNumberSelected(notification:)),
                    name: .courseNumberSelected, object: nil)
    }
    
    @objc func onProfessorSelected(notification: Notification){
        if let selectedItem = notification.object{
            let commentScreen = CommentScreenViewController()
            navigationController?.pushViewController(commentScreen, animated: true)
        }
    }
    
    @objc func onCourseNumberSelected(notification: Notification){
        if let selectedItem = notification.object{
            let searchResultScreen = ResultScreenViewController()
            navigationController?.pushViewController(searchResultScreen, animated: true)
        }
    }
    
    
    
    func setupSearchBottomSheet(type: String){
        //MARK: setting up bottom search sheet...
        if type == "Professor" {
            searchSheetNavController = UINavigationController(rootViewController: searchProfessorSheetController)
        } else {
            searchSheetNavController = UINavigationController(rootViewController: searchCourseNumberSheetController)
        }
        
        // setting up modal style...
        searchSheetNavController.modalPresentationStyle = .pageSheet
        
        if let bottomSearchSheet = searchSheetNavController.sheetPresentationController{
            bottomSearchSheet.detents = [.medium(), .large()]
            bottomSearchSheet.prefersGrabberVisible = true
        }
    }
    
    @objc func onSearchByProfessorButtonTapped(){
        // mock data for professor Database
        // TODO: 现在为MockData, 需要implem从firebase中获得所有ProfessorName, 注意firebase是async，需要用completion
        let Amy = Professor(name: "Amy")
        let Jake = Professor(name: "Jake")
        var ProfessorDatabase = [Amy, Jake]
        
        searchProfessorSheetController.namesForTableView.removeAll()
        searchProfessorSheetController.namesDatabase = ProfessorDatabase
        
        setupSearchBottomSheet(type: "Professor")
        present(searchSheetNavController, animated: true)
    }
    
    @objc func onSearchByCourseNumberButtonTapped(){
        
        // mock data for courseNumber Database
        // TODO: 现在为MockData, 需要implem从firebase中获得所有courseNumber，注意firebase是async，需要用completion
        // TODO: 一点迷思，或者可以本地cache一个所有课号的array，这样不用每次都查...
        let CS5001 = Course(courseID: "CS5001")
        let CS5002 = Course(courseID: "CS5002")
        var CourseNumberDatabase = [CS5001, CS5002]
        
        searchCourseNumberSheetController.namesForTableView.removeAll()
        searchCourseNumberSheetController.namesDatabase = CourseNumberDatabase
        
        setupSearchBottomSheet(type: "Course")
        present(searchSheetNavController, animated: true)
    }
}
