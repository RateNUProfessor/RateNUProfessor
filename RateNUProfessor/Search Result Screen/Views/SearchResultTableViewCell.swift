//
//  SearchResultTableViewCell.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    var wrapperCellView: UIView!
    var labelProfessorName: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupLabelProfessorName()
        initConstraints()
    }
    
    func setupWrapperCellView() {
        wrapperCellView = UIView()

        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 4.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = CGSize(width: 0, height: 2)
        wrapperCellView.layer.shadowRadius = 2.0
        wrapperCellView.layer.shadowOpacity = 0.7
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(wrapperCellView)
    }
    
    func setupLabelProfessorName() {
        labelProfessorName = UILabel()
        labelProfessorName.font = UIFont.boldSystemFont(ofSize: 16)
        labelProfessorName.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelProfessorName)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8), 
            wrapperCellView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            
            labelProfessorName.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 12),
            labelProfessorName.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            labelProfessorName.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
            labelProfessorName.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: -12)
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
