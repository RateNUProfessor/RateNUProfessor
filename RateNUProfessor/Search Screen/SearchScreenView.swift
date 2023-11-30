//
//  SearchScreenView.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit

class SearchScreenView: UIView {

    var labelSearch: UILabel!
    var labelProfName: UILabel!
    var labelCourseId: UILabel!
    var labelCollege: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupLabelSearch()
        setupProfName()
        setupCourseId()
        
        initConstraints()
        
    }
    
    func setupLabelSearch() {
        labelSearch = UILabel()
        labelSearch.text = "Search Professor"
        labelSearch.font = UIFont.boldSystemFont(ofSize: 32)
        labelSearch.textAlignment = .center
        labelSearch.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelSearch)
    }
    
    func initConstraints() {
        // Constraints for labelProfile (centered both horizontally and vertically)
        NSLayoutConstraint.activate([
            labelSearch.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            labelSearch.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
