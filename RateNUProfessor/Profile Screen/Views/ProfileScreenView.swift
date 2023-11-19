//
//  ProfileScreenView.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit

class ProfileScreenView: UIView {

    var labelProfile: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupLabelProfile()
        
        initConstraints()
        
    }
    
    func setupLabelProfile() {
        labelProfile = UILabel()
        labelProfile.text = "This is Profile Page"
        labelProfile.font = UIFont.boldSystemFont(ofSize: 32)
        labelProfile.textAlignment = .center
        labelProfile.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelProfile)
    }
    
    func initConstraints() {
        // Constraints for labelProfile (centered both horizontally and vertically)
        NSLayoutConstraint.activate([
            labelProfile.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            labelProfile.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
