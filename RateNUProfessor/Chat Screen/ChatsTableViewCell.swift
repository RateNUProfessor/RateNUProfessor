//
//  ChatsTableViewCell.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 12/2/23.
//

import UIKit

class ChatsTableViewCell: UITableViewCell {

    var wrapperCellView: UIView!
    var labelName: UILabel!
    var timeStamp: UILabel!
    var lastMessage: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupLabelName()
        setupTimeStamp()
        setupLastMessage()
        
        initConstraints()
    }
    
    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        
        //working with the shadows and colors...
        wrapperCellView.backgroundColor = AppColors.backgroundColor
        wrapperCellView.layer.cornerRadius = 6.0
        wrapperCellView.layer.shadowColor = UIColor.lightGray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 4.0
        wrapperCellView.layer.shadowOpacity = 0.4
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupLabelName(){
        labelName = UILabel()
        labelName.font = UIFont.boldSystemFont(ofSize: 20)
        labelName.textColor = .white
        labelName.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelName)
    }
    
    func setupTimeStamp() {
        timeStamp = UILabel()
        timeStamp.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        timeStamp.textColor = .white
        timeStamp.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(timeStamp)
    }
    
    func setupLastMessage(){
        lastMessage = UILabel()
        lastMessage.font = UIFont.systemFont(ofSize: 16)
        labelName.textColor = .white
        lastMessage.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(lastMessage)
    }
    
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            timeStamp.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -12),
            timeStamp.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 12),
            
            labelName.topAnchor.constraint(equalTo: timeStamp.topAnchor),
            labelName.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 12),
            labelName.trailingAnchor.constraint(lessThanOrEqualTo: timeStamp.leadingAnchor, constant: 4),
            
            lastMessage.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 12),
            lastMessage.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 8),
            
            wrapperCellView.heightAnchor.constraint(equalToConstant: 72)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

