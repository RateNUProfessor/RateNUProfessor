//
//  ChatTableViewCell.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 12/2/23.
//

import UIKit

enum MessageType {
    case incoming
    case outgoing
}

class ChatTableViewCell: UITableViewCell {
    var wrapperCellView: UIView!
    var labelName: UILabel!
    var labelDate: UILabel!
    var labelMessage: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupLabelName()
        setupLabelDate()
        setupLabelMessage()

    }
    
    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        wrapperCellView.layer.cornerRadius = 10
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupLabelName(){
        labelName = UILabel()
        labelName.font = UIFont.boldSystemFont(ofSize: 14)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelName)
    }
    
    func setupLabelDate(){
        labelDate = UILabel()
        labelDate.font = UIFont.boldSystemFont(ofSize: 12)
        labelDate.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelDate)
    }
    
    func setupLabelMessage(){
        labelMessage = UILabel()
        labelMessage.font = UIFont.systemFont(ofSize: 14)
        labelMessage.numberOfLines = 0
        labelMessage.lineBreakMode = .byWordWrapping
        labelMessage.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelMessage)
    }
    
    func initConstraints(messageType: MessageType){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 8),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            
        ])
        
        switch messageType{
        case .incoming:
            NSLayoutConstraint.activate([
                labelName.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 4),
                labelName.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 8),
                
                labelMessage.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 4),
                labelMessage.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 8),
                labelMessage.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -8),
                
                labelDate.topAnchor.constraint(equalTo: labelMessage.bottomAnchor, constant: 4),
                labelDate.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 8),
                
                wrapperCellView.bottomAnchor.constraint(greaterThanOrEqualTo: labelDate.bottomAnchor, constant: 8),
                
                self.heightAnchor.constraint(equalTo: wrapperCellView.heightAnchor, constant: 8)
            ])
            
        case .outgoing:
            NSLayoutConstraint.activate([
                labelName.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 4),
                labelName.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -8),
                
                labelMessage.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 4),
                labelMessage.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 8),
                labelMessage.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -8),
                
                labelDate.topAnchor.constraint(equalTo: labelMessage.bottomAnchor, constant: 4),
                labelDate.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -8),
                
                wrapperCellView.bottomAnchor.constraint(greaterThanOrEqualTo: labelDate.bottomAnchor, constant: 8),
                
                self.heightAnchor.constraint(equalTo: wrapperCellView.heightAnchor, constant: 8)
            ])
        }
        
    }
    
    func configure(with message: String, senderName: String, timestamp: Int64, type: MessageType) {
        labelMessage.text = message
        labelName.text = senderName
        
        let relativeDateFormatter = RelativeDateTimeFormatter()
        relativeDateFormatter.unitsStyle = .full
        
        let relativeDate = relativeDateFormatter
            .localizedString(for: Date(timeIntervalSince1970: TimeInterval(timestamp)), relativeTo: Date.now)

        switch type {
        case .incoming:
            wrapperCellView.backgroundColor = .systemGray6
            
            labelMessage.textColor = .darkGray
            labelDate.textColor = .darkGray
            labelName.textColor = .darkGray
            
            labelDate.text = "Received \(relativeDate)"
            labelName.textAlignment = .left
            labelMessage.textAlignment = .left
            labelDate.textAlignment = .left
            initConstraints(messageType: .incoming)
            
        case .outgoing:
            wrapperCellView.backgroundColor = AppColors.backgroundColor
            
            labelMessage.textColor = .darkGray
            labelDate.textColor = .darkGray
            labelName.textColor = .darkGray
            
            labelDate.text = "Sent \(relativeDate)"
            labelName.textAlignment = .right
            labelName.text = "Me"
            labelMessage.textAlignment = .right
            labelDate.textAlignment = .right
            //self.removeConstraints(self.constraints)
            //clearSubViewsConstraints()
            initConstraints(messageType: .outgoing)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
