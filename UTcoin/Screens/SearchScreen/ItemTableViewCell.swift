//
//  ItemTableViewCell.swift
//  UTcoin
//
//  Created by Роман Карасёв on 23.11.2022.
//

import UIKit

// MARK: - ItemTableViewCell

final class ItemTableViewCell: UITableViewCell {
    
    static let identifier   = "ItemTableViewCell"
    
    //MARK: ImageViews
    
    let itemImageView: UIImageView = {
        let imageView                                       = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor                           = .red
        imageView.clipsToBounds                             = true
        return imageView
    }()
    
    
    let shopImageView: UIImageView = {
        let imageView                                       = UIImageView()
        imageView.backgroundColor                           = .blue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    
    //MARK: Labels
    
    private let itemTitleLabel = UILabel(text: "",
                                         font: .systemFont(ofSize: 14))
    
    private let priceLabel     = UILabel(text: "",
                                         font: .systemFont(ofSize: 14, weight: .bold))
    
    
    //MARK: Buttons
    
    let cashbackButton = UIButton.createCashbackButton()
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
        selectionStyle = .none
        setOption()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setOption() {
        itemTitleLabel.numberOfLines = 2
        itemTitleLabel.lineBreakMode = .byCharWrapping
    }
    
    //MARK: renderData from ViewModel
    
    func render(from model: ProductViewModel) {
        
        GetImagesFromURL.shared.getImage(url: model.mainImage, imageView: itemImageView)
        GetImagesFromURL.shared.getImage(url: model.campaignImageURL, imageView: shopImageView)
        
        itemTitleLabel.text = model.name
        priceLabel.text     = model.price
        cashbackButton.setTitle(model.cashback, for: .normal)
    }
    
}

//MARK: - setConstraints

extension ItemTableViewCell {
    
    private func setConstraints() {
        
        addSubview(itemImageView)
        NSLayoutConstraint.activate(
            [itemImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
             itemImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
             itemImageView.heightAnchor.constraint(equalToConstant: 100),
             itemImageView.widthAnchor.constraint(equalToConstant: 100)
            ]
        )
        
        addSubview(cashbackButton)
        NSLayoutConstraint.activate(
            [cashbackButton.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                    constant: -5),
             cashbackButton.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor,
                                                     constant: 5)
            ]
        )
        
        addSubview(priceLabel)
        NSLayoutConstraint.activate(
            [priceLabel.bottomAnchor.constraint(equalTo: cashbackButton.topAnchor, constant: -5),
             priceLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 5)
            ]
        )
        
        addSubview(shopImageView)
        NSLayoutConstraint.activate(
            [shopImageView.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor,
                                                    constant: 5),
             shopImageView.heightAnchor.constraint(equalToConstant: 50),
             shopImageView.widthAnchor.constraint(equalToConstant: 50),
             shopImageView.bottomAnchor.constraint(equalTo: priceLabel.topAnchor,
                                                   constant: -5)
            ]
        )
        
        addSubview(itemTitleLabel)
        NSLayoutConstraint.activate(
            [itemTitleLabel.topAnchor.constraint(equalTo: topAnchor),
             itemTitleLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor,
                                                     constant: 5),
             itemTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
             itemTitleLabel.bottomAnchor.constraint(equalTo: shopImageView.topAnchor,
                                                    constant: -2),
            ]
        )
    }
}
