//
//  Chat.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 12/2/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Chat: Codable {
    @DocumentID var id: String?
    var latestTimeStamp: Int64?
    var lastMessage: String?
    var userEmails: [String]
    var userIds: [String]
}
