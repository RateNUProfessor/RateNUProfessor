//
//  SignUpProgressIndicatorManager.swift
//  RateNUProfessor
//
//  Created by Jiaqi Zhao on 11/19/23.
//

import Foundation

extension SignUpScreenViewController: ProgressSpinnerDelegate{
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
