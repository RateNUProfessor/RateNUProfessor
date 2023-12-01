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
    var averageScoreLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupTableViewComments()
        setupFloatingButtonAddComment()
        setupAverageScoreLabel()
        initConstraints()
    }
    
    func setupAverageScoreLabel() {
        averageScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        averageScoreLabel.textAlignment = .center
        // 添加到视图
        addSubview(averageScoreLabel)
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
            // Constraints for averageScoreLabel
            averageScoreLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            averageScoreLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            averageScoreLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            // Constraints for tableViewComments
            tableViewComments.topAnchor.constraint(equalTo: averageScoreLabel.bottomAnchor, constant: 10),
            tableViewComments.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            tableViewComments.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableViewComments.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            // Constraints for floatingButtonAddComment
            floatingButtonAddComment.widthAnchor.constraint(equalToConstant: 60), // Modified for a larger button
            floatingButtonAddComment.heightAnchor.constraint(equalToConstant: 60), // Modified for a larger button
            floatingButtonAddComment.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            floatingButtonAddComment.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
