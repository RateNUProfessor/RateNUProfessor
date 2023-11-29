
//
//  commonFunction.swift
//  RateNUProfessor
//
//  Created by 陈可轩 on 2023/11/29.
//

import Foundation
import UIKit

func showAlert(text: String, from viewController: UIViewController) {
    let alert = UIAlertController(
        title: "Error",
        message: text,
        preferredStyle: .alert
    )
    
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    
    viewController.present(alert, animated: true)
}
