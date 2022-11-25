//
//  DetailView.swift
//  UTcoin
//
//  Created by Роман Карасёв on 23.11.2022.
//

import UIKit

//MARK: - DetailView

class DetailView: UIView {
    
    // MARK: Properties
    
    var termsTableViewHeightConstraint: NSLayoutConstraint?
    var shopImageViewHeightConstraint: NSLayoutConstraint?
    
    //MARK: Views
#warning("доделать scrollView")
//    let mainScrollView: UIScrollView = {
//        let scroll                                       = UIScrollView()
//        scroll.isPagingEnabled                           = true
//        scroll.showsVerticalScrollIndicator              = false
//        scroll.showsHorizontalScrollIndicator            = false
//        scroll.translatesAutoresizingMaskIntoConstraints = false
//        return scroll
//    }()
    
    let itemsScrollView: UIScrollView = {
        let scroll                                       = UIScrollView()
        scroll.isPagingEnabled                           = true
        scroll.showsVerticalScrollIndicator              = false
        scroll.showsHorizontalScrollIndicator            = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    let shopImageView: UIImageView = {
        let imageView                                       = UIImageView()
        imageView.image                                     = Constants.Images.defaultImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let termsTableView: UITableView = {
        let tableView                                       = UITableView()
        tableView.bounces                                   = false
        tableView.backgroundColor                           = .clear
        tableView.separatorStyle                            = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TermsTableViewCell.self, forCellReuseIdentifier: TermsTableViewCell.identifier)
        return tableView
    }()
    
    //MARK: Labels
    
    let titleLabel                = UILabel(text: "",
                                            font: .systemFont(ofSize: 16, weight: .bold))
    
    let priceLabel                = UILabel(text: "",
                                            font: .systemFont(ofSize: 24, weight: .bold))
    
    private let cashbackLabel     = UILabel(text: "Кешбек",
                                            font: .systemFont(ofSize: 14, weight: .semibold))
    
    private let timeCashbackLabel = UILabel(text: "Время начисления кешбека",
                                            font: .systemFont(ofSize: 14, weight: .semibold))
    
    let dayCountLabel             = UILabel(text: "",
                                            font: .systemFont(ofSize: 12))
    
    private let termsLabel        = UILabel(text: "",
                                            font: .systemFont(ofSize: 14, weight: .semibold))
    
    let firstTermsCashbackLabel   = UILabel(text: "",
                                            font: .systemFont(ofSize: 14))
    
    let firstTermsDiscribeLabel   = UILabel(text: "",
                                            font: .systemFont(ofSize: 14, weight: .bold))
    
    //MARK: Buttons
    
    let cashbackButton = UIButton.createCashbackButton()
    
    let expandButton: UIButton = {
        let button                                       = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Развернуть", for: .normal)
        button.setTitleColor(Constants.Colors.mainColor, for: .normal)
        return button
    }()
    
    let buyButton: UIButton = {
        let button                                       = UIButton()
        button.titleLabel?.font                          = .systemFont(ofSize: 12)
        button.backgroundColor                           = Constants.Colors.mainColor
        button.layer.cornerRadius                        = UIScreen.main.bounds.size.height / 24 / 2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Купить с кешбеком", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setConstraints()
        setOptions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setOptions() {
        firstTermsCashbackLabel.textColor     = #colorLiteral(red: 0.9803285003, green: 0.3133740723, blue: 0.6123356819, alpha: 1)
        titleLabel.numberOfLines              = 0
        firstTermsDiscribeLabel.numberOfLines = 0
        firstTermsDiscribeLabel.lineBreakMode = .byCharWrapping
    }
}
// MARK: - setConstraints

extension DetailView {
    
    private func setConstraints() {
        
        termsTableViewHeightConstraint = NSLayoutConstraint(item: termsTableView,
                                                            attribute: .height,
                                                            relatedBy: .equal,
                                                            toItem: .none,
                                                            attribute: .height,
                                                            multiplier: 1,
                                                            constant: 0)
        
        shopImageViewHeightConstraint = NSLayoutConstraint(item: shopImageView,
                                                           attribute: .height,
                                                           relatedBy: .equal,
                                                           toItem: .none,
                                                           attribute: .height,
                                                           multiplier: 1,
                                                           constant: 50)
        
        //MARK: buyButton
        
        addSubview(buyButton)
        NSLayoutConstraint.activate(
            [buyButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
             buyButton.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                constant: 10),
             buyButton.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                 constant: -10),
             buyButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height / 24)
            ]
        )
        
        
//        addSubview(mainScrollView)
//        NSLayoutConstraint.activate(
//            [mainScrollView.topAnchor.constraint(equalTo: topAnchor),
//             mainScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
//             mainScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
//             mainScrollView.bottomAnchor.constraint(equalTo: buyButton.topAnchor,
//                                                    constant: -10)
//            ]
//        )
        
        //MARK: ItemsScrollView
        
        addSubview(itemsScrollView)
        NSLayoutConstraint.activate(
            [itemsScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
             itemsScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
             itemsScrollView.topAnchor.constraint(equalTo: topAnchor,
                                                  constant: 90),
             itemsScrollView.heightAnchor.constraint(equalTo: heightAnchor,
                                                     multiplier: 0.3)
            ]
        )
        
        //MARK: Title
        
        addSubview(titleLabel)
        NSLayoutConstraint.activate(
            [titleLabel.topAnchor.constraint(equalTo: itemsScrollView.bottomAnchor,
                                             constant: 5),
             titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                 constant: 10),
             titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                  constant: -10),
             titleLabel.heightAnchor.constraint(equalToConstant: 50)
            ]
        )
        
        //MARK: ShopImage
        
        addSubview(shopImageView)
        shopImageView.addConstraint(shopImageViewHeightConstraint!)
        NSLayoutConstraint.activate(
            [shopImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                constant: 5),
             shopImageView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                    constant: 10),             shopImageView.widthAnchor.constraint(equalToConstant: 100)
            ]
        )
        
        //MARK: Price
        
        addSubview(priceLabel)
        NSLayoutConstraint.activate(
            [priceLabel.topAnchor.constraint(equalTo: shopImageView.bottomAnchor,
                                             constant: 10),
             priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                 constant: 10)
            ]
        )
        
        //MARK: Cashback
        
        addSubview(cashbackLabel)
        NSLayoutConstraint.activate(
            [cashbackLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor,
                                                constant: 10),
             cashbackLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                    constant: 10)
            ]
        )
        
        addSubview(cashbackButton)
        NSLayoutConstraint.activate(
            [cashbackButton.topAnchor.constraint(equalTo: cashbackLabel.bottomAnchor,
                                                 constant: 5),
             cashbackButton.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                     constant: 10),
            ]
        )
        
        //MARK: Timecashback
        
        addSubview(timeCashbackLabel)
        NSLayoutConstraint.activate(
            [timeCashbackLabel.topAnchor.constraint(equalTo: cashbackButton.bottomAnchor,
                                                    constant: 10),
             timeCashbackLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                        constant: 10)
            ]
        )
        
        addSubview(dayCountLabel)
        NSLayoutConstraint.activate(
            [dayCountLabel.topAnchor.constraint(equalTo: timeCashbackLabel.bottomAnchor,
                                                constant: 5),
             dayCountLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                    constant: 10)
            ]
        )
        
        //MARK: Terms
        
        addSubview(termsLabel)
        NSLayoutConstraint.activate(
            [termsLabel.topAnchor.constraint(equalTo: dayCountLabel.bottomAnchor,
                                             constant: 10),
             termsLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                 constant: 10)
            ]
        )
        
        addSubview(firstTermsCashbackLabel)
        NSLayoutConstraint.activate(
            [firstTermsCashbackLabel.topAnchor.constraint(equalTo: termsLabel.bottomAnchor,
                                                          constant: 10),
             firstTermsCashbackLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                              constant: 10)
            ]
        )
        
        addSubview(firstTermsDiscribeLabel)
        NSLayoutConstraint.activate(
            [firstTermsDiscribeLabel.topAnchor.constraint(equalTo: termsLabel.bottomAnchor,
                                                          constant: 10),
             firstTermsDiscribeLabel.leadingAnchor.constraint(equalTo: firstTermsCashbackLabel.trailingAnchor,
                                                              constant: 2),
             firstTermsDiscribeLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                               constant: -10)
            ]
        )
        
        addSubview(termsTableView)
        termsTableView.addConstraint(termsTableViewHeightConstraint!)
        NSLayoutConstraint.activate(
            [termsTableView.topAnchor.constraint(equalTo: firstTermsDiscribeLabel.bottomAnchor,
                                                 constant: 2),
             termsTableView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                     constant: 10),
             termsTableView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                      constant: -10),
            ]
        )
        
        
        addSubview(expandButton)
        NSLayoutConstraint.activate(
            [expandButton.topAnchor.constraint(equalTo: termsTableView.bottomAnchor,
                                               constant: 5),
             expandButton.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                   constant: 10),
             expandButton.heightAnchor.constraint(equalToConstant: 30)
            ]
        )
    }
}


