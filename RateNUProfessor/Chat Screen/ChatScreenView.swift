//
//  ChatScreenView.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit

class ChatScreenView: UIView {

    var labelChat: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
    
        setupSearchButtons()
        initConstraints()
    }
    
    func setupSearchButtons() {
        labelChat = UILabel()
        labelChat.text = "Chat page"
        labelChat.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelChat)

    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            
            labelChat.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            labelChat.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            labelChat.heightAnchor.constraint(equalToConstant: 150),
            labelChat.widthAnchor.constraint(equalToConstant: 250),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
