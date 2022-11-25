//
//  SearchView.swift
//  UTcoin
//
//  Created by Роман Карасёв on 23.11.2022.
//


import UIKit

//MARK: - SearchView

class SearchView: UIView {
    
    // MARK: Properties
    
    var shopCollectionViewHeightConstraint: NSLayoutConstraint?
    
    //MARK: Views
    
    var shopCollectionView: UICollectionView = {
        let layout                                               = UICollectionViewFlowLayout()
        layout.scrollDirection                                   = .horizontal
        let collectionView                                       = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset                              = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        collectionView.isScrollEnabled                           = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ShopCollectionViewCell.self, forCellWithReuseIdentifier: ShopCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    let itemTableView: UITableView = {
        let tableView                                       = UITableView()
        tableView.bounces                                   = false
        tableView.backgroundColor                           = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: ItemTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: setConstraints
    private func setConstraints() {
        
        shopCollectionViewHeightConstraint = NSLayoutConstraint(item: shopCollectionView,
                                                                attribute: .height,
                                                                relatedBy: .equal,
                                                                toItem: .none,
                                                                attribute: .height,
                                                                multiplier: 1,
                                                                constant: 200)
        
        addSubview(shopCollectionView)
        shopCollectionView.addConstraint(shopCollectionViewHeightConstraint!)
        NSLayoutConstraint.activate(
            [shopCollectionView.topAnchor.constraint(equalTo: topAnchor,
                                                     constant: 150),
             shopCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                         constant: 20),
             shopCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                          constant: -20)
            ]
        )
        
        addSubview(itemTableView)
        NSLayoutConstraint.activate(
            [itemTableView.topAnchor.constraint(equalTo: shopCollectionView.bottomAnchor,
                                                constant: 10),
             itemTableView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                    constant: 20),
             itemTableView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                     constant: -20),
             itemTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ]
        )
    }
}


