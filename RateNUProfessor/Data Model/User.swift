//
//  User.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/19/23.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseAuth

struct User: Codable{
    @DocumentID var documentID: String?
    var id: String
    var name: String
    var email: String
    var password: String
    var campus: String
    var allComments: [SingleRateUnit]
    
    init(id: String, name: String, email: String, password: String, campus: String) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.campus = campus
        self.allComments = [SingleRateUnit]()
    }
    
    init(firebaseUser: FirebaseAuth.User) {
        self.id = firebaseUser.uid

        if let displayName = firebaseUser.displayName {
            self.name = displayName
        } else {
            self.name = "Default Name"
        }
        
        if let email = firebaseUser.email {
            self.email = email
        } else {
            self.email = "Default Email" // Provide a default email or handle nil case
        }
    
        self.password = ""
        self.allComments = [SingleRateUnit]()
        self.campus = ""
    }

}
