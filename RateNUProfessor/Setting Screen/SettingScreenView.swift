//
//  SettingScreenView.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit

class SettingScreenView: UIView {

    var profileImage: UIButton!
    var labelChangePic: UILabel!
    var labelName: UILabel!
    var textFieldName: UITextField!
    var labelCampus: UILabel!
    var buttonCampus: UIButton!
    var buttonChangePwd: UIButton!
    var buttonSave: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupProfileImage()
        setupLabelChangePic()
        setupLabelName()
        setupTextFieldName()
        setupLabelCampus()
        setupButtonCampus()
        setupButtonChangePwd()
        setupButtonSave()
        
        initConstraints()
        
    }
    
    func setupProfileImage() {
        profileImage = UIButton(type: .system)
        profileImage.setTitle("", for: .normal)
        profileImage.setImage(UIImage(systemName: "person.fill"), for: .normal)
        profileImage.contentHorizontalAlignment = .fill
        profileImage.contentVerticalAlignment = .fill
        profileImage.imageView?.contentMode = .scaleAspectFill
        profileImage.imageView?.layer.borderColor = AppColors.buttonColor.cgColor
        profileImage.imageView?.layer.borderWidth = 1.5
        profileImage.imageView?.layer.cornerRadius = 10
        profileImage.showsMenuAsPrimaryAction = true
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(profileImage)
    }
    
    func setupLabelChangePic() {
        labelChangePic = UILabel()
        labelChangePic.text = "tap to change avatar"
        labelChangePic.font = UIFont.systemFont(ofSize: 12)
        labelChangePic.textAlignment = .center
        labelChangePic.textColor = .lightGray
        labelChangePic.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelChangePic)
    }
    
    func setupLabelName() {
        labelName = UILabel()
        labelName.text = "username"
        labelName.font = UIFont.systemFont(ofSize: 18)
        labelName.textAlignment = .center
        labelName.textColor = .darkGray
        labelName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelName)
    }
    
    func setupTextFieldName(){
        textFieldName = UITextField()
        textFieldName.placeholder = "Name"
        textFieldName.borderStyle = .roundedRect
        textFieldName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldName)
    }
    
    func setupLabelCampus() {
        labelCampus = UILabel()
        labelCampus.text = "campus"
        labelCampus.font = UIFont.systemFont(ofSize: 18)
        labelCampus.textAlignment = .center
        labelCampus.textColor = .darkGray
        labelCampus.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelCampus)
    }
    
    func setupButtonCampus() {
        buttonCampus = UIButton(type: .system)
        buttonCampus.setTitle("San Jose", for: .normal)
        buttonCampus.showsMenuAsPrimaryAction = true
        buttonCampus.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonCampus)
    }
    
    func setupButtonChangePwd() {
        buttonChangePwd = UIButton(type: .system)
        buttonChangePwd.setTitle("Change password", for: .normal)
        buttonChangePwd.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        buttonChangePwd.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonChangePwd)
    }
    
    func setupButtonSave() {
        buttonSave = UIButton(type: .system)
        buttonSave.setTitle("Save", for: .normal)
        buttonSave.translatesAutoresizingMaskIntoConstraints = false
        buttonSave.titleLabel?.font = .boldSystemFont(ofSize: 16)
        buttonSave.setTitleColor(UIColor.white, for: .normal)
        buttonSave.backgroundColor = AppColors.buttonColor
        buttonSave.layer.cornerRadius = 8
        buttonSave.clipsToBounds = true
        self.addSubview(buttonSave)
    }
    
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            
            profileImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            profileImage.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 100),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            
            labelChangePic.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            labelChangePic.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 8),
            
            labelName.topAnchor.constraint(equalTo: labelChangePic.bottomAnchor, constant: 32),
            labelName.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            
            textFieldName.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 8),
            textFieldName.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            textFieldName.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            labelCampus.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 32),
            labelCampus.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            
            buttonCampus.topAnchor.constraint(equalTo: labelCampus.bottomAnchor, constant: 8),
            buttonCampus.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            
            buttonChangePwd.topAnchor.constraint(equalTo: buttonCampus.bottomAnchor, constant: 12),
            //buttonChangePwd.leadingAnchor.constraint(equalTo: labelName.leadingAnchor, constant: 200),
            buttonChangePwd.trailingAnchor.constraint(equalTo: textFieldName.trailingAnchor),
            
            buttonSave.topAnchor.constraint(equalTo: buttonChangePwd.bottomAnchor, constant: 32),
            buttonSave.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            buttonSave.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            buttonSave.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            buttonSave.heightAnchor.constraint(equalToConstant: 50)

        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
