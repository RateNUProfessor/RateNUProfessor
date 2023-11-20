//
//  SearchScreenViewController.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/14/23.
//

import UIKit

class SearchScreenViewController: UIViewController {
    
    let searchScreen = SearchScreenView()
    
    override func loadView() {
            view = searchScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Search"
        
    }
    

    

}
