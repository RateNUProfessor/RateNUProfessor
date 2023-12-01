//
//  TabBarScreenViewController.swift
//  RateNUProfessor
//
//  Created by 陈可轩 on 2023/11/19.
//

import UIKit

class TabBarScreenViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let tabSearch = UINavigationController(rootViewController: SearchScreenViewController())
        let tabSearchBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(systemName: "magnifyingglass.circle")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(systemName: "magnifyingglass.circle.fill")
        )
        tabSearch.tabBarItem = tabSearchBarItem
        tabSearch.title = "Search"
        
        let tabProfile = UINavigationController(rootViewController: ProfileScreenViewController())
        let tabProfileBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(systemName: "person.fill")
        )
        tabProfile.tabBarItem = tabProfileBarItem
        tabProfile.title = "Profile"
        
        let tabChat = UINavigationController(rootViewController: ChatScreenViewController())
        let tabChatBarItem = UITabBarItem(
            title: "Chat",
            image: UIImage(systemName: "message")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.black),
            selectedImage: UIImage(systemName: "message.fill")
        )
        tabChat.tabBarItem = tabChatBarItem
        tabChat.title = "Chat"
        
        self.viewControllers = [tabSearch, tabChat, tabProfile]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
    }

}
