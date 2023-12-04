//
//  PostCommentTableViewCell.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit

class PostCommentTableViewCell: UITableViewCell {

    var wrapperCellView: UIView!
    var labelName: UILabel!
    var labelInfo: UILabel!
    var labelComment: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupLabelName()
        setupLableInfo()
        setupLabelComment()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 6.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 4.0
        wrapperCellView.layer.shadowOpacity = 0.4
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupLabelName(){
        labelName = UILabel()
        labelName.font = UIFont.boldSystemFont(ofSize: 20)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.lineBreakMode = .byWordWrapping
        wrapperCellView.addSubview(labelName)
    }
    
    func setupLableInfo(){
        labelInfo = UILabel()
        labelInfo.font = UIFont.boldSystemFont(ofSize: 14)
        labelInfo.textAlignment = .right
        labelInfo.textColor = .darkGray
        labelInfo.translatesAutoresizingMaskIntoConstraints = false
        labelInfo.numberOfLines = 0
        labelInfo.lineBreakMode = .byWordWrapping
        wrapperCellView.addSubview(labelInfo)
    }
    
    func setupLabelComment() {
        labelComment = UILabel()
        labelComment.font = UIFont.systemFont(ofSize: 16)
        labelComment.translatesAutoresizingMaskIntoConstraints = false
        labelComment.lineBreakMode = .byWordWrapping
        labelComment.numberOfLines = 0
        wrapperCellView.addSubview(labelComment)
    }

    
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            labelName.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 10),
            labelName.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            //labelName.heightAnchor.constraint(equalToConstant: 20),
            labelName.widthAnchor.constraint(lessThanOrEqualTo: wrapperCellView.widthAnchor),
            
            labelInfo.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 8),
            labelInfo.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            labelInfo.widthAnchor.constraint(lessThanOrEqualTo: wrapperCellView.widthAnchor),
            
            labelComment.topAnchor.constraint(equalTo: labelInfo.bottomAnchor, constant: 8),
            labelComment.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            labelComment.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
            labelComment.widthAnchor.constraint(lessThanOrEqualTo: wrapperCellView.widthAnchor, constant: 8),
            labelComment.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: -8)
            
            // wrapperCellView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
