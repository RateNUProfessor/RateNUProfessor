//
//  ContactsTableViewManager.swif.swift
//  RateNUProfessor
//
//  Created by 陈可轩 on 2023/11/28.
//

import Foundation
import UIKit

extension CommentScreenViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allScoresList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewCommentsID, for: indexPath) as! CommentTableViewCell
        let curRateItem = allScoresList[indexPath.row]
       
        cell.labelScore.text = "\(curRateItem.rateScore)"
        cell.labelClass.text = "\(curRateItem.rateClass)"
        cell.labelComment.text = "\(curRateItem.rateComment)"
        
        return cell
    }
    
//    func convertToDateAndTime(_ date: TimeInterval? ) -> String? {
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = .current
//        if let date = date {
//            let date = Date(timeIntervalSince1970: date)
//            dateFormatter.dateFormat = "YY/MM/dd, hh:mm"
//            return dateFormatter.string(from: date)
//        } else {
//            return nil
//        }
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {


    }

}
