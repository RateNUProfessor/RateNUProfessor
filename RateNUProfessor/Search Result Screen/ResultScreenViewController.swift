//
//  ResultScreenViewController.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit
import Firebase

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
        
        resultScreen.tableViewProfessors.register(SearchResultTableViewCell.self, forCellReuseIdentifier: Configs.selectedCourseToGetProf)
        resultScreen.tableViewProfessors.delegate = self
        resultScreen.tableViewProfessors.dataSource = self
        resultScreen.tableViewProfessors.separatorStyle = .none
        
        if let courseID = selectedCourseID {
            fetchProfessorsForCourse(courseID: courseID)
        }
    }

    private func fetchProfessorsForCourse(courseID: String) {
        print("Fetching professors for course ID: \(courseID)")
        var updatedProfessors = [Professor]()
        
        let db = Firestore.firestore()
        print("line45")
        db.collection("courses").document(courseID).collection("professor").getDocuments { [weak self] (querySnapshot, error) in
            print("line47")
            guard let self = self else {
                print("Error: Self is nil")
                return
            }

            if let error = error {
                print("Error fetching professors for course: \(error.localizedDescription)")
                return
            }
            
            print("line58")
            if let querySnapshot = querySnapshot, querySnapshot.documents.isEmpty {
                self.foundProfessors = false
                self.professors = []
                self.resultScreen.tableViewProfessors.reloadData()
                return
            }
            print("line65")
            print("Query Snapshot Documents: \(querySnapshot!.documents)")
            print("line67")
            let group = DispatchGroup()
            for document in querySnapshot!.documents {
                group.enter()
                let professorID = document.documentID
                print("Found professor ID: \(professorID)")
                
                db.collection("professors").document(professorID).getDocument { (profDoc, err) in
                    if let err = err {
                        print("Error fetching professor document: \(err.localizedDescription)")
                        group.leave()
                        return
                    }

                    if let profDoc = profDoc, profDoc.exists {
                        if let professorName = profDoc.data()?["name"] as? String,
                            let professorScore = profDoc.data()?["avgScore"] as? String {
                            var professor = Professor(name: professorName)
                            professor.professorUID = professorID
                            professor.avgScore = Double(professorScore)!
                            updatedProfessors.append(professor)
                        }
                    }
                    group.leave()
                }
                
                
            }

            group.notify(queue: .main) {
                print("Completed fetching professors. Total count: \(updatedProfessors.count)")
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

        guard let cell = tableView.dequeueReusableCell(withIdentifier: Configs.selectedCourseToGetProf, for: indexPath) as? SearchResultTableViewCell else {
            return UITableViewCell()
        }

        let professor = professors[indexPath.row]
        cell.labelProfessorName?.text = professor.name
        cell.labelAvgScore.text = "\(professor.avgScore)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if foundProfessors {
            let selectedProfessor = professors[indexPath.row]
            let commentScreenVC = CommentScreenViewController()
            commentScreenVC.professorObj = selectedProfessor
            navigationController?.pushViewController(commentScreenVC, animated: true)
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
