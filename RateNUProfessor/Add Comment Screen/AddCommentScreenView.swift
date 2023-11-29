//
//  AddCommentScreenView.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit

class AddCommentScreenView: UIView {

    // TODO: courseNumber改成下拉框，否则之后根据String课号查询的时候无法查到
    var labelCourseNumber: UILabel!
    var textCourseNumber: UITextField!

    var labelScore: UILabel!
    var textScore: UITextField!

    var labelComment: UILabel!
    var textComment: UITextField!

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .white

        setupViews()
        setupConstraints()
    }

    func setupViews() {
        labelCourseNumber = UILabel()
        labelCourseNumber.text = "Course Number:"
        labelCourseNumber.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelCourseNumber)

        textCourseNumber = UITextField()
        textCourseNumber.borderStyle = .roundedRect
        textCourseNumber.placeholder = "Enter course number"
        textCourseNumber.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textCourseNumber)

        labelScore = UILabel()
        labelScore.text = "Score:"
        labelScore.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelScore)

        textScore = UITextField()
        textScore.borderStyle = .roundedRect
        textScore.placeholder = "Enter score"
        textScore.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textScore)

        labelComment = UILabel()
        labelComment.text = "Comment:"
        labelComment.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelComment)

        textComment = UITextField()
        textComment.borderStyle = .roundedRect
        textComment.placeholder = "Enter comment"
        textComment.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textComment)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            labelCourseNumber.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            labelCourseNumber.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),

            textCourseNumber.topAnchor.constraint(equalTo: labelCourseNumber.bottomAnchor, constant: 8),
            textCourseNumber.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textCourseNumber.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            textCourseNumber.heightAnchor.constraint(equalToConstant: 40),

            labelScore.topAnchor.constraint(equalTo: textCourseNumber.bottomAnchor, constant: 20),
            labelScore.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),

            textScore.topAnchor.constraint(equalTo: labelScore.bottomAnchor, constant: 8),
            textScore.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textScore.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            textScore.heightAnchor.constraint(equalToConstant: 40),

            labelComment.topAnchor.constraint(equalTo: textScore.bottomAnchor, constant: 20),
            labelComment.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),

            textComment.topAnchor.constraint(equalTo: labelComment.bottomAnchor, constant: 8),
            textComment.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textComment.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            textComment.heightAnchor.constraint(equalToConstant: 80),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
