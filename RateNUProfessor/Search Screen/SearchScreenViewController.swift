//
//  SearchScreenViewController.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

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

    @objc func onCourseNumberSelected(notification: Notification){
        if let selectedCourse = notification.object as? Course { // 这里将notification.object转换为Course类型
            let searchResultScreen = ResultScreenViewController()
            searchResultScreen.selectedCourseID = selectedCourse.courseID // 使用转换后的对象获取courseID
            navigationController?.pushViewController(searchResultScreen, animated: true)
        }
    }
    
    
    
    func setupSearchBottomSheet(type: String){
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
