//
//  CommentScreenView.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit

class CommentScreenView: UIView {
    var tableViewComments: UITableView!
    var floatingButtonAddComment: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupTableViewComments()
        setupFloatingButtonAddComment()
        initConstraints()
    }
    
    func setupTableViewComments() {
        tableViewComments = UITableView()
        tableViewComments.register(CommentTableViewCell.self, forCellReuseIdentifier: Configs.tableViewCommentsID)
        tableViewComments.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewComments)
    }
    
    // TODO: 怎么让这个button变大一点...
    func setupFloatingButtonAddComment() {
        floatingButtonAddComment = UIButton(type: .system)
        floatingButtonAddComment.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        floatingButtonAddComment.tintColor = AppColors.buttonColor
        floatingButtonAddComment.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(floatingButtonAddComment)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            tableViewComments.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            tableViewComments.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            tableViewComments.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableViewComments.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            floatingButtonAddComment.widthAnchor.constraint(equalToConstant: 40),
            floatingButtonAddComment.heightAnchor.constraint(equalToConstant: 40),
            floatingButtonAddComment.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            floatingButtonAddComment.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
