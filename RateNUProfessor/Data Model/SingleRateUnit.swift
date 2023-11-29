//
//  SingleRateUnit.swift
//  RateNUProfessor
//
//  Created by 陈可轩 on 2023/11/18.
//

// 暂时想到的attributes，供后续参考

import Foundation

struct SingleRateUnit: Codable {
    var rateStudent: User
    var rateProfessor: Professor
    var rateClass: String
    var rateScore: Double
    var rateComment: String
    
    init(rateStudent: User, rateProfessor: Professor, rateClass: String, rateScore: Double, rateComment: String) {
        self.rateStudent = rateStudent
        self.rateProfessor = rateProfessor
        self.rateClass = rateClass
        self.rateScore = rateScore
        self.rateComment = rateComment
    }
}
