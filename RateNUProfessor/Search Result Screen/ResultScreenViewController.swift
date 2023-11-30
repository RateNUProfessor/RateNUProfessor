//
//  ResultScreenViewController.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit
import Firebase

// 展示所有和这个课关联的professor
// 点击每一个tableViewCell进入相应professor的comment screen
class ResultScreenViewController: UIViewController {

    let resultScreen = ResultScreenView()
    var selectedCourseID: String?
    var professors: [Professor] = []
    var foundProfessors = true
    
    override func loadView() {
        view = resultScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Search Result"
        
        //TODO: 从firebase获取这个课号的所有professor，展示在tableView里
        //TODO: 点击这个tableview可以进入到对应professor的comment page
        resultScreen.tableViewProfessors.register(SearchResultTableViewCell.self, forCellReuseIdentifier: "selectedCourseToGetProf")
        resultScreen.tableViewProfessors.delegate = self
        resultScreen.tableViewProfessors.dataSource = self
        
        if let courseID = selectedCourseID {
            fetchProfessorsForCourse(courseID: courseID)
        }
    }
    
    private func fetchProfessorsForCourse(courseID: String) {
        var updatedProfessors = [Professor]()
        
        let db = Firestore.firestore()
        db.collection("courses").document(courseID).collection("professors").getDocuments { [weak self] (querySnapshot, error) in
            guard let self = self else {
                print("Error: Self is nil")
                return
            }

            if let error = error {
                print("Error fetching professors for course: \(error.localizedDescription)")
                return
            }

            if let querySnapshot = querySnapshot, querySnapshot.documents.isEmpty {
                self.foundProfessors = false
                self.professors = []
                self.resultScreen.tableViewProfessors.reloadData()
                return
            }

            let group = DispatchGroup()
            for document in querySnapshot!.documents {
                group.enter()
                let professorID = document.documentID
                db.collection("professors").document(professorID).getDocument { (profDoc, err) in
                    if let profDoc = profDoc, profDoc.exists {
                        var professor = Professor(name: profDoc.data()?["name"] as? String ?? "Unknown")
                        professor.professorUID = professorID
                        updatedProfessors.append(professor)
                    } else {
                        print("Error fetching professor: \(err?.localizedDescription ?? "Unknown error")")
                    }
                    group.leave()
                }
            }

            group.notify(queue: .main) {
                print("Fetched professors group notify: \(updatedProfessors)")
                self.professors = updatedProfessors
                self.resultScreen.tableViewProfessors.reloadData()
            }
        }
    }

    
}

extension ResultScreenViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foundProfessors ? professors.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !foundProfessors {
            let cell = UITableViewCell()
            cell.textLabel?.text = "No professor found for this course."
            cell.textLabel?.textAlignment = .center
            return cell
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "selectedCourseToGetProf", for: indexPath) as? SearchResultTableViewCell else {
            return UITableViewCell()
        }

        let professor = professors[indexPath.row]
        cell.textLabel?.text = professor.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProfessor = professors[indexPath.row]
        let commentScreenVC = CommentScreenViewController()
        commentScreenVC.professorObj = selectedProfessor
        navigationController?.pushViewController(commentScreenVC, animated: true)
    }
    
}
