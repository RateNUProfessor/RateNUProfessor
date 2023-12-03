//
//  SettingProgressIndicatorManager.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 12/3/23.
//

import Foundation

extension SettingScreenViewController: ProgressSpinnerDelegate{
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
