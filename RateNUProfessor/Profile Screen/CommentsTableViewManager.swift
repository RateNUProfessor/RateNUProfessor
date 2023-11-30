//
//  CommentsTableViewManager.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/29/23.
//

import Foundation
import UIKit

extension ProfileScreenViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewProfileCommentID, for: indexPath) as! PostCommentTableViewCell
        cell.labelName.text = comments[indexPath.row].rateProfessor.name
        cell.labelInfo.text = "\(comments[indexPath.row].rateClass), \(comments[indexPath.row].rateCampus), \(comments[indexPath.row].rateSemaster)"
        cell.labelComment.text = "\(comments[indexPath.row].rateComment)"
        return cell
    }
}
