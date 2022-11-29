//
//  UIViewController + Ext.swift
//  UTcoin
//
//  Created by Роман Карасёв on 29.11.2022.
//

import UIKit

extension UIViewController {
    
    
    func setAlert(title: String, viewController: UIViewController) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            alertController.addAction (UIAlertAction (title: "OK", style: .default))
            viewController.present(alertController, animated: true)
        }
        
    }
}
