//
//  ChatScreenView.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit

class ChatScreenView: UIView {

    var logo: UIImageView!
    var labelChat: UILabel!
    var tableViewChats: UITableView!
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
    
        setupLogo()
        setuplabelChat()
        setupTableViewContacts()
        initConstraints()
    }
    
    func setupLogo(){
        logo = UIImageView()
        logo.image = UIImage(systemName: "sun.max")
        logo.contentMode = .scaleAspectFit
        logo.clipsToBounds = true
        logo.layer.masksToBounds = true
        logo.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(logo)
    }
    
    func setuplabelChat(){
        labelChat = UILabel()
        labelChat.font = .boldSystemFont(ofSize: 16)
        labelChat.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelChat)
    }
    
    func setupTableViewContacts(){
        tableViewChats = UITableView()
        tableViewChats.register(ChatsTableViewCell.self, forCellReuseIdentifier: Configs.tableViewChatsID)
        tableViewChats.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewChats)
    }
   
    func initConstraints(){
        NSLayoutConstraint.activate([
            logo.widthAnchor.constraint(equalToConstant: 32),
            logo.heightAnchor.constraint(equalToConstant: 32),
            logo.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            logo.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            labelChat.topAnchor.constraint(equalTo: logo.topAnchor),
            labelChat.bottomAnchor.constraint(equalTo: logo.bottomAnchor),
            labelChat.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 16),
            
            tableViewChats.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 8),
            tableViewChats.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            tableViewChats.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableViewChats.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
