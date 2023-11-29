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
    var reatClass: String
    var rateScore: Double
    
    init(rateStudent: User, rateProfessor: Professor, reatClass: String, rateScore: Double) {
        self.rateStudent = rateStudent
        self.rateProfessor = rateProfessor
        self.reatClass = reatClass
        self.rateScore = rateScore
    }
}
