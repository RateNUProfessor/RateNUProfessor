//
//  AddNewChatScreenView.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 12/2/23.
//

import UIKit

class AddNewChatScreenView: UIView {

    var tableViewMessages: UITableView!
    var bottomChatWrapper: UIView!
    var textViewMessage: UITextView!
    var buttonSend: UIButton!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        
        setupBottomChatWrapper()
        setupTableViewMessages()
        setupTextFieldChatName()
        setupButtonAddChat()
        initConstraints()
    }
    
    func setupTableViewMessages(){
        tableViewMessages = UITableView()
        tableViewMessages.register(ChatTableViewCell.self, forCellReuseIdentifier: Configs.tableViewChatID)
        tableViewMessages.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewMessages)
    }
    
    func setupBottomChatWrapper(){
        bottomChatWrapper = UIView()
        bottomChatWrapper.backgroundColor = .white
        bottomChatWrapper.layer.borderWidth = 2
        bottomChatWrapper.layer.borderColor = AppColors.buttonColor.cgColor
        bottomChatWrapper.layer.cornerRadius = 8
        bottomChatWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomChatWrapper)
    }
    
    func setupTextFieldChatName() {
        textViewMessage = UITextView()
        textViewMessage.font = UIFont(name: "ArialMT", size: 16)
        textViewMessage.keyboardType = .default
        textViewMessage.isScrollEnabled = false
        textViewMessage.sizeToFit()
        textViewMessage.translatesAutoresizingMaskIntoConstraints = false
        self.bottomChatWrapper.addSubview(textViewMessage)
    }
    
    func setupButtonAddChat() {
        buttonSend = UIButton(type: .system)
        buttonSend.setTitle("", for: .normal)
        buttonSend.setImage(UIImage(systemName: "paperplane.circle")?.withRenderingMode(.alwaysTemplate), for: .normal)
        buttonSend.tintColor = AppColors.buttonColor
        buttonSend.contentHorizontalAlignment = .fill
        buttonSend.contentVerticalAlignment = .fill
        buttonSend.imageView?.contentMode = .scaleAspectFit
        buttonSend.layer.cornerRadius = 16
        buttonSend.imageView?.layer.shadowOffset = .zero
        buttonSend.imageView?.layer.shadowRadius = 0.8
        buttonSend.imageView?.layer.shadowOpacity = 0.7
        buttonSend.imageView?.clipsToBounds = true
        buttonSend.translatesAutoresizingMaskIntoConstraints = false
        self.bottomChatWrapper.addSubview(buttonSend)
    }
    
    
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            bottomChatWrapper.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            bottomChatWrapper.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            bottomChatWrapper.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, constant: -16),
            
            buttonSend.widthAnchor.constraint(equalToConstant: 32),
            buttonSend.heightAnchor.constraint(equalToConstant: 32),
            buttonSend.bottomAnchor.constraint(equalTo: self.bottomChatWrapper.bottomAnchor, constant: -4),
            buttonSend.trailingAnchor.constraint(equalTo: self.bottomChatWrapper.trailingAnchor, constant: -2),
            
            textViewMessage.bottomAnchor.constraint(equalTo: buttonSend.bottomAnchor),
            textViewMessage.leadingAnchor.constraint(equalTo: self.bottomChatWrapper.leadingAnchor, constant: 4),
            textViewMessage.topAnchor.constraint(lessThanOrEqualTo: buttonSend.topAnchor),
            textViewMessage.heightAnchor.constraint(lessThanOrEqualToConstant: 200),
            textViewMessage.trailingAnchor.constraint(equalTo: buttonSend.leadingAnchor, constant: -4),
            
            bottomChatWrapper.topAnchor.constraint(equalTo: textViewMessage.topAnchor, constant: -4),
            
            tableViewMessages.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableViewMessages.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableViewMessages.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            tableViewMessages.heightAnchor.constraint(greaterThanOrEqualToConstant: self.frame.height-200),
            tableViewMessages.bottomAnchor.constraint(equalTo: bottomChatWrapper.topAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
