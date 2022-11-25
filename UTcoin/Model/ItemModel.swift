//
//  ItemModel.swift
//  UTcoin
//
//  Created by Роман Карасёв on 24.11.2022.
//

import Foundation

// MARK: - Results
struct Results: Codable {
    let successful                    : Bool
    let errorMessage, errorMessageCode: String
    let campaigns                     : [Campaign]
    let products                      : [Product]
    let more, moreCampaigns           : Bool
}

// MARK: - Campaign
struct Campaign: Codable {
    let id         : Int
    let name       : String
    let cashback   : String
    let actions    : [Action]
    let imageURL   : String
    let paymentTime: String

    enum CodingKeys: String, CodingKey {
        case id, name, cashback, actions
        case imageURL = "imageUrl"
        case paymentTime
    }
}

// MARK: - Action
struct Action: Codable {
    let value: String
    let text : String
}


// MARK: - Product
struct Product: Codable {
    let id              : Int
    let name            : String
    let cashback        : String
    let actions         : [Action]
    let imageUrls       : [String]
    let price           : String
    let campaignName    : String
    let campaignImageURL: String
    let paymentTime     : String

    enum CodingKeys: String, CodingKey {
        case id, name, cashback, actions, imageUrls, price, campaignName
        case campaignImageURL = "campaignImageUrl"
        case paymentTime
    }
}
