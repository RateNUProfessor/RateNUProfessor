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
    
    init(id: String, name: String, email: String, password: String) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
    }
    
    init(firebaseUser: FirebaseAuth.User) {
        self.id = firebaseUser.uid
        
        // TODO: 如果name是空的话要怎么处理
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
        
        // TODO: Handle password assignment according to your requirements
        self.password = ""
    }

}
