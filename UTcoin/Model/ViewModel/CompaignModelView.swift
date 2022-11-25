//
//  CompaignModelView.swift
//  UTcoin
//
//  Created by Роман Карасёв on 24.11.2022.
//

import Foundation

//MARK: - CompaignModelView

struct CompaignModelView {
    
    // MARK: Properties
    
    let id          : Int
    let name        : String
    let image       : String
    let cashback    : String
    let actions     : [Action]
    let paymentTime : String
    
    // MARK: Initialization
    
    init(from campaign: [Campaign], index: IndexPath) {
    
        self.id          = campaign[index.row].id
        self.name        = campaign[index.row].name
        self.image       = campaign[index.row].imageURL
        self.cashback    = campaign[index.row].cashback
        self.actions     = campaign[index.row].actions
        self.paymentTime = campaign[index.row].paymentTime
        
    }
}
