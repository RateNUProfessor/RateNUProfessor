//
//  CommentTableViewCell.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    var wrapperCellView: UIView!
    var labelScore: UILabel!
    var labelClass: UILabel!
    var labelComment: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupWrapperCellView()
        setupScoreLabel()
        setupClassLabel()
        setupCommentLabel()
        initConstraints()
    }
    
    func setupWrapperCellView() {
        wrapperCellView = UIView()
        wrapperCellView.backgroundColor = .white
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(wrapperCellView)
    }
    
    func setupScoreLabel() {
        labelScore = UILabel()
        labelScore.font = UIFont.boldSystemFont(ofSize: 20)
        labelScore.textAlignment = .right
        labelScore.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelScore)
    }
    
    func setupClassLabel() {
        labelClass = UILabel()
        labelClass.font = UIFont.systemFont(ofSize: 16)
        labelClass.textColor = .gray
        labelClass.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelClass)
    }
    
    func setupCommentLabel() {
        labelComment = UILabel()
        labelComment.font = UIFont.systemFont(ofSize: 16)
        labelComment.textColor = .darkGray
        labelComment.numberOfLines = 2 // Adjust the number of lines as needed
        labelComment.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelComment)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            
            labelScore.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            labelScore.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
            labelScore.widthAnchor.constraint(equalToConstant: 60),
            
            labelClass.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            labelClass.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
            labelClass.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 4),
            
            labelComment.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            labelComment.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
            labelComment.topAnchor.constraint(equalTo: labelClass.bottomAnchor, constant: 4),
            labelComment.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
