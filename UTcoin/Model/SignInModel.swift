//
//  SignInModel.swift
//  UTcoin
//
//  Created by Роман Карасёв on 24.11.2022.
//

import Foundation


// MARK: - Empty
struct Number: Codable {
    
    let successful                      : Bool?
    let errorMessage, errorMessageCode  : String?
    let normalizedPhone, explainMessage : String?
    let sessionID                       : String?
}
