//
//  SingleRateUnit.swift
//  RateNUProfessor
//
//  Created by 陈可轩 on 2023/11/18.
//

import Foundation

struct SingleRateUnit: Codable {
    var commentId: String
    var rateStudent: User
    var rateProfessor: Professor
    var rateClass: String
    var rateScore: Double
    var rateComment: String
    var rateSemester: String
    var rateCampus: String
  
    init(commentId: String, rateStudent: User, rateProfessor: Professor, rateClass: String, rateScore: Double, rateComment: String, rateSemester: String, rateCampus: String) {
        self.commentId = commentId
        self.rateStudent = rateStudent
        self.rateProfessor = rateProfessor
        self.rateClass = rateClass
        self.rateScore = rateScore
        self.rateSemester = rateSemester
        self.rateCampus = rateCampus
        self.rateComment = rateComment
    }
}
