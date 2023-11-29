//
//  File.swift
//  RateNUProfessor
//
//  Created by 陈可轩 on 2023/11/18.
//


// 暂时想到的attributes，供后续参考

import Foundation

struct Professor: Codable {
    var professorUID: String
    // the name of professor
    var name: String
    // the classes this professor teach
    var classToTeach: [String]
    // average point
    var avgScore: Double
    // all rate comments for this professor
    var rateArray: [SingleRateUnit]
    
    init(name: String) {
        self.professorUID = String()
        self.name = name
        self.classToTeach = [String]()
        self.avgScore = 0.0
        self.rateArray = [SingleRateUnit]()
    }
}
