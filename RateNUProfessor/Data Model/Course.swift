//
//  Couese.swift
//  RateNUProfessor
//
//  Created by 陈可轩 on 2023/11/28.
//

import Foundation

struct Course: Codable {
    // identify the course Number, e.g.: CS5002
    var courseID: String
    // the name of professor
    var ProfessorList: [Professor]
    
    init(courseID: String) {
        self.courseID = courseID
        self.ProfessorList = [Professor]()
    }
}
