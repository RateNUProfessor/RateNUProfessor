//
//  AddCommentScreenView.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit

class AddCommentScreenView: UIView {
    
    var labelCourseNumber: UILabel!
    var textFieldCourse: UITextField!

    var labelScore: UILabel!
    var textScore: UITextField!
    var labelFullScore: UILabel!
    
    var labelSemester: UILabel!
    var textFieldYear: UITextField!
    var textFieldTerm: UITextField!
    
    let pickerYear = UIPickerView()
    let pickerTerm = UIPickerView()
    let pickerCourse = UIPickerView()

    var labelComment: UILabel!
    var textComment: UITextView!
    
    var buttonAdd: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .white

        setupViews()
        setupConstraints()
    }

    func setupViews() {
        
        labelCourseNumber = UILabel()
        labelCourseNumber.text = "Course Number"
        labelCourseNumber.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelCourseNumber)
        
        textFieldCourse = UITextField()
        textFieldCourse.inputView = pickerCourse
        textFieldCourse.borderStyle = .roundedRect
        textFieldCourse.font = .systemFont(ofSize: 16, weight: .bold)
        textFieldCourse.placeholder = "Select Course Number"
        textFieldCourse.textColor = UIColor.darkGray
        textFieldCourse.translatesAutoresizingMaskIntoConstraints = false
        textFieldCourse.contentHorizontalAlignment = .center
        self.addSubview(textFieldCourse)

        labelScore = UILabel()
        labelScore.text = "Score"
        labelScore.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelScore)

        textScore = UITextField()
        textScore.borderStyle = .roundedRect
        textScore.keyboardType = .decimalPad
        textScore.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textScore)
        
        labelFullScore = UILabel()
        labelFullScore.text = "/ 5.0"
        labelFullScore.font = UIFont.boldSystemFont(ofSize: 24)
        labelFullScore.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelFullScore)
        
        labelSemester = UILabel()
        labelSemester.text = "Semester Taken"
        labelSemester.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelSemester)
        
        textFieldYear = UITextField()
        textFieldYear.inputView = pickerYear
        textFieldYear.borderStyle = .roundedRect
        textFieldYear.font = .systemFont(ofSize: 16, weight: .bold)
        textFieldYear.placeholder = "Year"
        textFieldYear.textColor = UIColor.darkGray
        textFieldYear.translatesAutoresizingMaskIntoConstraints = false
        textFieldYear.contentHorizontalAlignment = .center
        self.addSubview(textFieldYear)
        
        textFieldTerm = UITextField()
        textFieldTerm.inputView = pickerTerm
        textFieldTerm.borderStyle = .roundedRect
        textFieldTerm.font = .systemFont(ofSize: 16, weight: .bold)
        textFieldTerm.placeholder = "Term"
        textFieldTerm.textColor = UIColor.darkGray
        textFieldTerm.translatesAutoresizingMaskIntoConstraints = false
        textFieldTerm.contentHorizontalAlignment = .center
        self.addSubview(textFieldTerm)
        
        labelComment = UILabel()
        labelComment.text = "Comments"
        labelComment.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelComment)

        textComment = UITextView()
        textComment.layer.cornerRadius = 10
        textComment.layer.borderColor = UIColor.systemGray5.cgColor
        textComment.layer.borderWidth = 1
        textComment.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        textComment.font = .systemFont(ofSize: 16, weight: .semibold)
        textComment.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textComment)
        
        buttonAdd = UIButton(type: .system)
        buttonAdd.setTitle("Rate", for: .normal)
        buttonAdd.setTitleColor(UIColor.white, for: .normal)
        buttonAdd.backgroundColor = AppColors.buttonColor
        buttonAdd.layer.cornerRadius = 8
        buttonAdd.clipsToBounds = true
        buttonAdd.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        buttonAdd.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonAdd)
        
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            labelScore.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            labelScore.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),

            textScore.topAnchor.constraint(equalTo: labelScore.bottomAnchor, constant: 8),
            textScore.leadingAnchor.constraint(equalTo: labelScore.leadingAnchor, constant: 80),
            textScore.heightAnchor.constraint(equalToConstant: 50),
            textScore.widthAnchor.constraint(equalToConstant: 30),
            
            labelFullScore.topAnchor.constraint(equalTo: textScore.topAnchor),
            labelFullScore.leadingAnchor.constraint(equalTo: textScore.trailingAnchor, constant: 20),
            labelFullScore.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            labelFullScore.heightAnchor.constraint(equalToConstant: 50),
            labelFullScore.widthAnchor.constraint(equalTo: textScore.widthAnchor),
            
            labelCourseNumber.topAnchor.constraint(equalTo: labelFullScore.bottomAnchor, constant: 20),
            labelCourseNumber.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),

            textFieldCourse.topAnchor.constraint(equalTo: labelCourseNumber.bottomAnchor, constant: 8),
            textFieldCourse.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textFieldCourse.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            textFieldCourse.heightAnchor.constraint(equalToConstant: 40),
            textFieldCourse.widthAnchor.constraint(equalTo: textComment.widthAnchor),
            
            labelSemester.topAnchor.constraint(equalTo: textFieldCourse.bottomAnchor, constant: 20),
            labelSemester.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),

            textFieldYear.topAnchor.constraint(equalTo: labelSemester.bottomAnchor, constant: 8),
            textFieldYear.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textFieldYear.heightAnchor.constraint(equalToConstant: 40),
            textFieldYear.widthAnchor.constraint(equalToConstant: 150),
            
            textFieldTerm.topAnchor.constraint(equalTo: labelSemester.bottomAnchor, constant: 8),
            textFieldTerm.leadingAnchor.constraint(equalTo: textFieldYear.trailingAnchor, constant: 30),
            textFieldTerm.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            textFieldTerm.heightAnchor.constraint(equalToConstant: 40),

            labelComment.topAnchor.constraint(equalTo: textFieldTerm.bottomAnchor, constant: 20),
            labelComment.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),

            textComment.topAnchor.constraint(equalTo: labelComment.bottomAnchor, constant: 8),
            textComment.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textComment.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            textComment.heightAnchor.constraint(equalToConstant: 80),
            
            buttonAdd.topAnchor.constraint(equalTo: textComment.bottomAnchor, constant: 20),
            buttonAdd.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            buttonAdd.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            buttonAdd.heightAnchor.constraint(equalToConstant: 44),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
