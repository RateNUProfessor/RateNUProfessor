//
//  Message.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 12/2/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Message:Codable {
    @DocumentID var id: String?
    var msgText: String
    var senderEmail: String
    var timestamp: Int64
    
    init(msgText: String, senderEmail: String, timestamp: Int64) {
        self.msgText = msgText
        self.senderEmail = senderEmail
        self.timestamp = timestamp
    }
}
