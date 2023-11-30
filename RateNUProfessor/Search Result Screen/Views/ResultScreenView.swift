//
//  ResultScreenView.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit

class ResultScreenView: UIView {
    
//    var labelSearch: UILabel!
    var tableViewProfessors: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
//        setupLabelSearch()
        setupTableViewProfessors()
        initConstraints()
        
    }
    
//    func setupLabelSearch() {
//        labelSearch = UILabel()
//        labelSearch.text = "This is Search Result Page"
//        labelSearch.font = UIFont.boldSystemFont(ofSize: 32)
//        labelSearch.textAlignment = .center
//        labelSearch.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(labelSearch)
//    }
    
    func setupTableViewProfessors() {
        tableViewProfessors = UITableView()
        tableViewProfessors.translatesAutoresizingMaskIntoConstraints = false
        tableViewProfessors.register(SearchResultTableViewCell.self, forCellReuseIdentifier: "selectedCourseToGetProf")
        self.addSubview(tableViewProfessors)
    }
    
    func initConstraints() {
        // Constraints for labelProfile (centered both horizontally and vertically)
        NSLayoutConstraint.activate([
//            labelSearch.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            labelSearch.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            tableViewProfessors.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableViewProfessors.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableViewProfessors.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tableViewProfessors.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
