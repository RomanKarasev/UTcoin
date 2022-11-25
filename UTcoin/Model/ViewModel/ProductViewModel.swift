//
//  ProductViewModel.swift
//  UTcoin
//
//  Created by Роман Карасёв on 24.11.2022.
//


import Foundation

//MARK: - ProductViewModel

struct ProductViewModel {
    
    // MARK: Properties
    
    let id              : Int
    let name            : String
    let cashback        : String
    let actions         : [Action]
    let imageUrls       : [String]
    let price           : String
    let campaignName    : String
    let campaignImageURL: String
    let paymentTime     : String
    let mainImage       : String
    
    // MARK: Initialization
    
    init(from products: [Product], index: IndexPath) {
    
        self.id               = products[index.row].id
        self.name             = products[index.row].name
        self.cashback         = products[index.row].cashback
        self.actions          = products[index.row].actions
        self.imageUrls        = products[index.row].imageUrls
        self.price            = products[index.row].price
        self.campaignName     = products[index.row].campaignName
        self.campaignImageURL = products[index.row].campaignImageURL
        self.paymentTime      = products[index.row].paymentTime
        self.mainImage        = products[index.row].imageUrls[0]
    }
}
