//
//  ChatUser.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/30/23.
//

import Foundation
import MessageKit

struct ChatUser: SenderType, Equatable {
    var senderId: String
    var displayName: String
}
