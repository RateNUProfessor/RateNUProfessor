//
//  ResultScreenViewController.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit

// 展示所有和这个课关联的professor
// 点击每一个tableViewCell进入相应professor的comment screen
class ResultScreenViewController: UIViewController {

    let resultScreen = ResultScreenView()
    
    override func loadView() {
        view = resultScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Search Result"
        
        //TODO: 从firebase获取这个课号的所有professor，展示在tableView里
        //TODO: 点击这个tableview可以进入到对应professor的comment page
    }
}
