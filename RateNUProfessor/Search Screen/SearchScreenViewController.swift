//
//  SearchScreenViewController.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

// 现在的逻辑是可以根据professor Name搜索，或者根据课号搜索
// （因为它们是两个object不能放在一起，并且firebase noSQL数据库暂时没有了解到怎么联合查询
// 如果点击search by professor name, 进入comment screen, 直接展示有关这个professor的所有comment
// 如果点击search by course number, 进入search result screen, 展示所有和这个课关联的professors，然后再点击professor，进入comment screen

//TODO: 美化一下这个页面button
//TODO: 如果有更好的搜索想法可以讨论
class SearchScreenViewController: UIViewController {
    let searchScreen = SearchScreenView()
    let notificationCenter = NotificationCenter.default
    
    let searchProfessorSheetController = SearchProfessorBottomSheetController()
    let searchCourseNumberSheetController = SearchCourseNumberBottomSheetController()
    var searchSheetNavController: UINavigationController!
    
    var currentUser:FirebaseAuth.User?
    
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
        if let selectedItem = notification.object as? Professor {
            let commentController = CommentScreenViewController()
            commentController.professorObj = selectedItem
            navigationController?.pushViewController(commentController, animated: true)
        }
    }
    
    //TODO: search by courseNumber所有都没写
    @objc func onCourseNumberSelected(notification: Notification){
        if let selectedItem = notification.object as? Course {
            let searchResultController = ResultScreenViewController()
            navigationController?.pushViewController(searchResultController, animated: true)
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
        
        var ProfessorDatabase = [Professor]()
        
        let db = Firestore.firestore()
        db.collection("professors").getDocuments { [weak self] (querySnapshot, err) in
            guard let self = self else { return }

            if let err = err {
                print("Error getting documents: \(err)")
                return
            } else {
                for document in querySnapshot!.documents {
                    var professor = Professor(name: document.data()["name"] as? String ?? "Unknown")
                    professor.professorUID = document.documentID

                    ProfessorDatabase.append(professor)
                }

                // Update your UI here with the fetched professors
                self.searchProfessorSheetController.namesForTableView.removeAll()
                self.searchProfessorSheetController.namesDatabase = ProfessorDatabase

                self.setupSearchBottomSheet(type: "Professor")
                self.present(self.searchSheetNavController, animated: true)

            }
        }
    }
    
    @objc func onSearchByCourseNumberButtonTapped(){
        
        var CourseNumberDatabase = [Course]()

        let db = Firestore.firestore()
        db.collection("courses").getDocuments { [weak self] (querySnapshot, err) in
            guard let self = self else { return }

            if let err = err {
                print("Error getting documents: \(err)")
                return
            } else {
                for document in querySnapshot!.documents {
                    let courseID = document.data()["id"] as? String ?? "Unknown ID"
                    let courseName = document.data()["name"] as? String ?? "No Course Name"
                    
                    let course = Course(courseID: courseID)
                    
                    CourseNumberDatabase.append(course)
                }

                // Update your UI here with the fetched courses
                self.searchCourseNumberSheetController.namesForTableView.removeAll()
                self.searchCourseNumberSheetController.namesDatabase = CourseNumberDatabase

                self.setupSearchBottomSheet(type: "Course")
                self.present(self.searchSheetNavController, animated: true)

            }
        }
    }
}
