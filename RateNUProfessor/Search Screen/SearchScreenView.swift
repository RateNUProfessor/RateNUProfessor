//
//  SearchScreenView.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit

class SearchScreenView: UIView {

    var labelSearch: UILabel!
    var searchByProfessorButton: UIButton!
    var searchByCourseNumberButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupLabelSearch()
        setupSearchButtons()
        initConstraints()
    }
    
    func setupLabelSearch() {
        labelSearch = UILabel()
        labelSearch.text = "This is Search Page"
        labelSearch.font = UIFont.boldSystemFont(ofSize: 32)
        labelSearch.textAlignment = .center
        labelSearch.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelSearch)
    }
    
    func setupSearchButtons() {
        searchByProfessorButton = UIButton()
        searchByProfessorButton.setTitle("Search by Professor Name", for: .normal)
        searchByProfessorButton.setTitleColor(.blue, for: .normal)
        searchByProfessorButton.addTarget(self, action: #selector(searchByProfessorTapped), for: .touchUpInside)
        searchByProfessorButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(searchByProfessorButton)
        
        searchByCourseNumberButton = UIButton()
        searchByCourseNumberButton.setTitle("Search by Course Number", for: .normal)
        searchByCourseNumberButton.setTitleColor(.blue, for: .normal)
        searchByCourseNumberButton.addTarget(self, action: #selector(searchByCourseNumberTapped), for: .touchUpInside)
        searchByCourseNumberButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(searchByCourseNumberButton)
    }
    
    @objc func searchByProfessorTapped() {
        // Handle search by professor name action
        // Add your logic here
        print("Search by professor name button tapped")
    }
    
    @objc func searchByCourseNumberTapped() {
        // Handle search by course number action
        // Add your logic here
        print("Search by course number button tapped")
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            labelSearch.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            labelSearch.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            searchByProfessorButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            searchByProfessorButton.topAnchor.constraint(equalTo: labelSearch.bottomAnchor, constant: 20),
            
            searchByCourseNumberButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            searchByCourseNumberButton.topAnchor.constraint(equalTo: searchByProfessorButton.bottomAnchor, constant: 20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
