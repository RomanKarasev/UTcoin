//
//  UIString + Ext.swift
//  UTcoin
//
//  Created by Роман Карасёв on 28.11.2022.
//

import UIKit

extension String {
    
    enum ValidTypes {
        case number
        case code
    }
    
    enum RegularEx: String {
        case number = "[0-9]{10,}"
        case code = "[0-9]{4,}"
    }
    
    func isValid(validTypes: ValidTypes) -> Bool {
        let format = "SELF MATCHES %@"
        var regularEx = ""
        
        switch validTypes {
            case .number:  regularEx = RegularEx.number.rawValue
            case .code: regularEx = RegularEx.code.rawValue
        }
        return NSPredicate(format: format, regularEx).evaluate(with: self)
    }
}
