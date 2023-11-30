//
//  ProfileScreenView.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit

class ProfileScreenView: UIView {

    var profileImage: UIImageView!
    var labelName: UILabel!
    var labelCampus: UILabel!
    var labelPost: UILabel!
    var tableViewComments: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupPofileImage()
        setupLabelName()
        setupLabelCampus()
        setupLabelPost()
        setupTabelViewComments()
        
        initConstraints()
        
    }
    
    func setupPofileImage() {
        profileImage = UIImageView()
        profileImage.image = UIImage(systemName: "person.fill")
        profileImage.contentMode = .scaleToFill
        profileImage.clipsToBounds = true
        profileImage.layer.masksToBounds = true
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(profileImage)
    }
    
    func setupLabelName() {
        labelName = UILabel()
        labelName.textAlignment = .center
        labelName.text = "Name"
        labelName.font = .boldSystemFont(ofSize: 20)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelName)
    }
    
    func setupLabelCampus() {
        labelCampus = UILabel()
        labelCampus.textAlignment = .center
        labelCampus.text = "Campus"
        labelCampus.font = .systemFont(ofSize: 18)
        labelCampus.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelCampus)
    }
    
    func setupLabelPost() {
        labelPost = UILabel()
        labelPost.textAlignment = .left
        labelPost.font = .boldSystemFont(ofSize: 20)
        labelPost.text = "Recent Posts"
        labelPost.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelPost)
    }
    
    func setupTabelViewComments(){
        tableViewComments = UITableView()
        tableViewComments.register(PostCommentTableViewCell.self, forCellReuseIdentifier: Configs.tableViewProfileCommentID)
        tableViewComments.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewComments)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            profileImage.widthAnchor.constraint(equalToConstant: 100),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            profileImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            profileImage.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            
            labelName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 40),
            labelName.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 100),
            
            labelCampus.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 4),
            labelCampus.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            labelCampus.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor),

            labelPost.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 32),
            labelPost.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            
            tableViewComments.topAnchor.constraint(equalTo: labelPost.bottomAnchor, constant: 8),
            tableViewComments.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            tableViewComments.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableViewComments.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
