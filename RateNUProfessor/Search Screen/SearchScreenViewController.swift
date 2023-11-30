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
        if let selectedItem = notification.object{
            let commentScreen = CommentScreenViewController()
            navigationController?.pushViewController(commentScreen, animated: true)
        }
    }
    
    //TODO: search by courseNumber所有都没写
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
//        let MockProf = Professor(name: "MockProf")
//        let Jake = Professor(name: "Jake")
//        var ProfessorDatabase = [MockProf, Jake]
        
        self.searchProfessorSheetController.namesDatabase.removeAll()
        getAllProfessorsFromFireBase { [weak self] names in
            guard let self = self else { return }
            
            self.searchProfessorSheetController.namesDatabase.append(contentsOf: names)
            print(self.searchProfessorSheetController.namesDatabase)
            self.setupSearchBottomSheet(type: "Professor")
            self.present(self.searchSheetNavController, animated: true)
        }
        
//        searchProfessorSheetController.namesForTableView.removeAll()
//        searchProfessorSheetController.namesDatabase = ProfessorDatabase
//
//        setupSearchBottomSheet(type: "Professor")
//        present(searchSheetNavController, animated: true)
    }
    
    func getAllProfessorsFromFireBase(completion: @escaping ([Professor]) -> Void) {
        var tmp = [Professor]()
        let db = Firestore.firestore()
        let professorsCollection = db.collection("professors")

        professorsCollection.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    do {
                       // Extracting user data
                       let professorsData = document.data()
                       if let professorName = professorsData["name"] as? String{
                           let professor = Professor(name: professorName)
                           tmp.append(professor)
                       } else {
                           print("Professor data does not contain a name")
                       }
                   }
                }
                completion(tmp)

            }
        }
    }
    
    @objc func onSearchByCourseNumberButtonTapped(){
        
        // mock data for courseNumber Database
        // TODO: 现在为MockData, 需要implem从firebase中获得所有courseNumber，注意firebase是async，需要用completion
        // TODO: 一点迷思，或者可以本地cache一个所有课号的array，这样不用每次都查...
//        let CS5001 = Course(courseID: "CS5001")
//        let CS5002 = Course(courseID: "CS5002")
//        var CourseNumberDatabase = [CS5001, CS5002]
//
//        searchCourseNumberSheetController.namesForTableView.removeAll()
//        searchCourseNumberSheetController.namesDatabase = CourseNumberDatabase
//
//        setupSearchBottomSheet(type: "Course")
//        present(searchSheetNavController, animated: true)
        
        self.searchCourseNumberSheetController.namesDatabase.removeAll()
        getAllCoursesFromFireBase { [weak self] names in
            guard let self = self else { return }
            
            self.searchCourseNumberSheetController.namesDatabase.append(contentsOf: names)
            print(self.searchCourseNumberSheetController.namesDatabase)
            self.setupSearchBottomSheet(type: "Course")
            self.present(self.searchSheetNavController, animated: true)
        }
    }
    
    func getAllCoursesFromFireBase(completion: @escaping ([Course]) -> Void) {
        var tmp = [Course]()
        let db = Firestore.firestore()
        let coursesCollection = db.collection("courses")

        coursesCollection.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    do {
                       // Extracting user data
                       let courseData = document.data()
                       if let courseId = courseData["id"] as? String{
                           let course = Course(courseID: courseId)
                           tmp.append(course)
                       } else {
                           print("Professor data does not contain a name")
                       }
                   }
                }
                completion(tmp)

            }
        }
    }
}
