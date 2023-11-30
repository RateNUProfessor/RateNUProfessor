//
//  User.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/19/23.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable{
    var id: String
    var name: String
    var email: String
    var password: String
    var campus: String
    
    init(id: String, name: String, email: String, password: String, campus: String) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.campus = campus
    }
}
