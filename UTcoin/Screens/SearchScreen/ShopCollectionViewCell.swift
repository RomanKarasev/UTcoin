//
//  ShopCollectionViewCell.swift
//  UTcoin
//
//  Created by Роман Карасёв on 23.11.2022.
//


import Foundation
import UIKit

//MARK: - ShopCollectionViewCell

class ShopCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    
    static let identifier = "ShopCollectionViewCell"
    
    //MARK: Views
    
    let banerImageView: UIImageView = {
        let imageView                                       = UIImageView()
        imageView.backgroundColor                           = .clear
        imageView.contentMode                               = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: Buttons
    
    let cashbackButton = UIButton.createCashbackButton()
    
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private Methods
    
    private func  setView() {
        backgroundColor     = .systemBackground
        layer.cornerRadius  = 20
        layer.shadowRadius  = 3
        layer.shadowOpacity = 0.4
        layer.shadowOffset  = CGSize.zero
        layer.shadowColor   = UIColor.black.cgColor
        clipsToBounds       = false
    }
    
    //MARK: renderData from ViewModel
    
    func render(from model: CompaignModelView) {
        
        GetImagesFromURL.shared.getImage(url: model.image, imageView: banerImageView)
        
        cashbackButton.setTitle(model.cashback, for: .normal)
    }
}

//MARK: - setConstraints
extension ShopCollectionViewCell {
    
    private func setConstraints() {
        addSubview(banerImageView)
        NSLayoutConstraint.activate(
            [banerImageView.topAnchor.constraint(equalTo: topAnchor),
             banerImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
             banerImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
             banerImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            ]
        )
        
        banerImageView.addSubview(cashbackButton)
        NSLayoutConstraint.activate(
            [cashbackButton.bottomAnchor.constraint(equalTo: banerImageView.bottomAnchor,
                                                    constant: -10),
             cashbackButton.leadingAnchor.constraint(equalTo: banerImageView.leadingAnchor,
                                                     constant: 10)
            ]
        )
    }
}

