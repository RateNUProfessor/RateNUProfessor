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
        
        setupFloatingButtonAddComment()
        setupTableViewComments()
        initConstraints()
    }
    
    func setupTableViewComments(){
        tableViewComments = UITableView()
        tableViewComments.register(CommentTableViewCell.self, forCellReuseIdentifier: Configs.tableViewCommentsID)
        tableViewComments.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewComments)
    }
    
    func setupFloatingButtonAddComment(){
        floatingButtonAddComment = UIButton(type: .system)
        floatingButtonAddComment.setTitle("", for: .normal)
        floatingButtonAddComment.setImage(UIImage(systemName: "person.crop.circle.fill.badge.plus")?.withRenderingMode(.alwaysOriginal), for: .normal)
        floatingButtonAddComment.contentHorizontalAlignment = .fill
        floatingButtonAddComment.contentVerticalAlignment = .fill
        floatingButtonAddComment.imageView?.contentMode = .scaleAspectFit
        floatingButtonAddComment.layer.cornerRadius = 16
        floatingButtonAddComment.imageView?.layer.shadowOffset = .zero
        floatingButtonAddComment.imageView?.layer.shadowRadius = 0.8
        floatingButtonAddComment.imageView?.layer.shadowOpacity = 0.7
        floatingButtonAddComment.imageView?.clipsToBounds = true
        floatingButtonAddComment.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(floatingButtonAddComment)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            tableViewComments.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            tableViewComments.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            tableViewComments.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableViewComments.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            floatingButtonAddComment.widthAnchor.constraint(equalToConstant: 48),
            floatingButtonAddComment.heightAnchor.constraint(equalToConstant: 48),
            floatingButtonAddComment.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            floatingButtonAddComment.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    
}
