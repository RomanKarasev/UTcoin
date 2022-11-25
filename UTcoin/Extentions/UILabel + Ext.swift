//
//  UILabel + Ext.swift
//  UTcoin
//
//  Created by Роман Карасёв on 23.11.2022.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont?) {
        self.init()
        self.text                                       = text
        self.font                                       = font
        self.textColor                                  = .label
        self.textAlignment                              = .left
        self.adjustsFontSizeToFitWidth                  = true
        self.translatesAutoresizingMaskIntoConstraints  = false
    }
    
    
}



