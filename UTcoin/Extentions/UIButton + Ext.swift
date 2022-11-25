//
//  UIButton + Ext.swift
//  UTcoin
//
//  Created by Роман Карасёв on 23.11.2022.
//

import Foundation
import UIKit


extension UIButton {
    
    static func createCashbackButton() -> UIButton {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.translatesAutoresizingMaskIntoConstraints             = false
        button.titleLabel?.font                                      = .systemFont(ofSize: 14)
        button.layer.cornerRadius                                    = 15
        button.backgroundColor                                       = #colorLiteral(red: 0.9803285003, green: 0.3133740723, blue: 0.6123356819, alpha: 1)
        button.layer.shadowColor                                     = UIColor.black.cgColor
        button.layer.shadowOpacity                                   = 0.3
        button.layer.shadowRadius                                    = 3
        button.layer.shadowOffset                                    = CGSize.zero
        return button
    }
}
