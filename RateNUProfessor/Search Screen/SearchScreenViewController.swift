//
//  SearchScreenViewController.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit

class SearchScreenViewController: UIViewController {
    
    let searchScreen = SearchScreenView()
    
    let searchSheetController = SearchBottomSheetController()
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
    }
    
    func setupSearchBottomSheet(){
        //MARK: setting up bottom search sheet...
//        if category == "Professor" {
//            searchSheetController.namesForTableView.removeAll()
//            searchSheetController.namesDatabase = ProfessorDatabase
//        } else {
//            searchSheetController.namesForTableView.removeAll()
//            searchSheetController.namesDatabase = CourseNumberDatabase
//        }
            
        searchSheetNavController = UINavigationController(rootViewController: searchSheetController)
        
        // MARK: setting up modal style...
        searchSheetNavController.modalPresentationStyle = .pageSheet
        
        if let bottomSearchSheet = searchSheetNavController.sheetPresentationController{
            bottomSearchSheet.detents = [.medium(), .large()]
            bottomSearchSheet.prefersGrabberVisible = true
        }
    }
    
    @objc func onSearchByProfessorButtonTapped(){
        var ProfessorDatabase = ["Marvin Cook","Samira Jimenez","Coral Hancock","Xander Wade","Terence Mcneil","Dewey Buckley","Ophelia Higgins","Asiya Anthony","Francesco Knight","Claude Gonzalez","Demi Decker","Casey Park","Jon Hendrix","Hope Harvey","Richie Alexander","Carmen Proctor","Mercedes Callahan","Yahya Gibbs","Julian Pittman","Shauna Ray"]
        
        searchSheetController.namesForTableView.removeAll()
        searchSheetController.namesDatabase = ProfessorDatabase
        
        setupSearchBottomSheet()
        present(searchSheetNavController, animated: true)
    }
    
    @objc func onSearchByCourseNumberButtonTapped(){
        var CourseNumberDatabase = ["CS5001", "CS5002"]
        
        searchSheetController.namesForTableView.removeAll()
        searchSheetController.namesDatabase = CourseNumberDatabase
        
        setupSearchBottomSheet()
        present(searchSheetNavController, animated: true)
    }
}
