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
    
        setupSearchButtons()
        initConstraints()
    }
    
    
    func setupSearchButtons() {
        searchByProfessorButton = UIButton()
        searchByProfessorButton.setImage(UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysTemplate), for: .normal)
        searchByProfessorButton.setTitle("By Professor Name", for: .normal)
        searchByProfessorButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        searchByProfessorButton.setTitleColor(UIColor.white, for: .normal)
        searchByProfessorButton.tintColor = .white
        searchByProfessorButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        searchByProfessorButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        searchByProfessorButton.backgroundColor = AppColors.buttonColor
        searchByProfessorButton.layer.cornerRadius = 8
        searchByProfessorButton.clipsToBounds = true
        searchByProfessorButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(searchByProfessorButton)
        
        searchByCourseNumberButton = UIButton()
        searchByCourseNumberButton.setImage(UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysTemplate), for: .normal)
        searchByCourseNumberButton.setTitle("By Course Number", for: .normal)
        searchByCourseNumberButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        searchByCourseNumberButton.setTitleColor(UIColor.white, for: .normal)
        searchByCourseNumberButton.tintColor = .white
        searchByCourseNumberButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        searchByCourseNumberButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        searchByCourseNumberButton.backgroundColor = AppColors.buttonColor
        searchByCourseNumberButton.layer.cornerRadius = 8
        searchByCourseNumberButton.clipsToBounds = true
        searchByCourseNumberButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(searchByCourseNumberButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            
            searchByProfessorButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            searchByProfessorButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            searchByProfessorButton.heightAnchor.constraint(equalToConstant: 150),
            searchByProfessorButton.widthAnchor.constraint(equalToConstant: 250),
            
            searchByCourseNumberButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            searchByCourseNumberButton.topAnchor.constraint(equalTo: searchByProfessorButton.bottomAnchor, constant: 48),
            searchByCourseNumberButton.heightAnchor.constraint(equalToConstant: 150),
            searchByCourseNumberButton.widthAnchor.constraint(equalToConstant: 250),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
