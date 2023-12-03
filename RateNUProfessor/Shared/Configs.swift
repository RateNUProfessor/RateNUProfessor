//
//  Configs.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/19/23.
//

import Foundation
import UIKit
import CryptoKit

class Configs{
    static let tableViewProfileCommentID = "tableViewProfileCommentID"
    static let searchTableViewID = "searchTableViewID"
    static let tableViewCommentsID = "tableViewCommentsID"
    static let selectedCourseToGetProf = "selectedCourseToGetProf"
    static let tableViewChatsID = "tableViewChatsID"
    static let tableViewUsersID = "tableViewUsersID"
    static let tableViewChatID = "tableViewChat"
    
    static func showErrorAlert(message:String, viewController: UIViewController){
            let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            
            viewController.present(alert, animated: true)
    }
    
    static func generateChatIDFromEmails(_ emails: [String]) -> String{
        var lowercasedEmails = [String]()
        
        for email in emails{
            lowercasedEmails.append(email.lowercased())
        }
        
        let sortedEmails = lowercasedEmails.sorted()
        let joinedEmails = sortedEmails.joined()
        
        let joinedEmailsData = Data(joinedEmails.utf8)
        let hashed = Insecure.MD5.hash(data: joinedEmailsData)
        return hashed.compactMap{
            String(format: "%02x", $0)
        }.joined()
    }
    
    static func getRelativeDate(_ timestamp: Int64)->String{
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        let relativeDate = formatter.localizedString(
            for: Date(timeIntervalSince1970: TimeInterval(timestamp)),
            relativeTo: Date.now)
        
        return "\(relativeDate)"
    }
}
