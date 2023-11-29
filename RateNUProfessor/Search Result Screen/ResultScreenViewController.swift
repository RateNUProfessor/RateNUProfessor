//
//  ResultScreenViewController.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit

class ResultScreenViewController: UIViewController {

    let resultScreen = ResultScreenView()
    
    override func loadView() {
        view = resultScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Search Result"
    }
}
