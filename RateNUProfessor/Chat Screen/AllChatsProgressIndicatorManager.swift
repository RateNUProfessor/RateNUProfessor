//
//  AllChatsProgressIndicatorManager.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 12/2/23.
//

import Foundation

extension ChatScreenViewController: ProgressSpinnerDelegate{
    func showActivityIndicator(){
        addChild(childProgressView)
        view.addSubview(childProgressView.view)
        childProgressView.didMove(toParent: self)
    }
    
    func hideActivityIndicator(){
        childProgressView.willMove(toParent: nil)
        childProgressView.view.removeFromSuperview()
        childProgressView.removeFromParent()
    }
}
