//
//  NotificationNames.swift
//  RateNUProfessor
//
//  Created by 陈可轩 on 2023/11/28.
//

import Foundation

extension Notification.Name{
    static let professorSelected = Notification.Name("professorSelected")
    static let courseNumberSelected = Notification.Name("courseNumberSelected")
    static let otherUserSelectedForChat = Notification.Name("otherUserSelectedForChat")
    static let userSignedOut = Notification.Name("userSignedOut")
}
