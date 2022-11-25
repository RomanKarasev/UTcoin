//
//  GetImagesFromURL.swift
//  UTcoin
//
//  Created by Роман Карасёв on 25.11.2022.
//

import Foundation
import UIKit

class GetImagesFromURL {
    
    static let shared = GetImagesFromURL()
    
    func getImage(url: String, imageView: UIImageView)  {
        let url  = URL(string: url)
        
        if let data = try? Data(contentsOf: url!) {
            imageView.image = UIImage(data: data)
        }
    }
}
