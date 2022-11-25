//
//  MainScrolView.swift
//  UTcoin
//
//  Created by Роман Карасёв on 25.11.2022.
//


import UIKit

//MARK: - MainScrolView

class MainScrolView: UIScrollView {
    
    // MARK: Properties
    
    var termsTableViewHeightConstraint: NSLayoutConstraint?
    var shopImageViewHeightConstraint: NSLayoutConstraint?
    
    //MARK: Views
    let contentView: UIView = {
        let view = UIView()
        view.frame.size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height + 300)
        return view
    }()
    
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
   
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
        setOptions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setOptions() {
        backgroundColor                           = .systemBackground
        isPagingEnabled                           = true
        showsVerticalScrollIndicator              = false
        showsHorizontalScrollIndicator            = false
        translatesAutoresizingMaskIntoConstraints = false
        contentSize                               = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height + 300)
        firstTermsCashbackLabel.textColor         = #colorLiteral(red: 0.9803285003, green: 0.3133740723, blue: 0.6123356819, alpha: 1)
        titleLabel.numberOfLines                  = 0
        firstTermsDiscribeLabel.numberOfLines     = 0
        firstTermsDiscribeLabel.lineBreakMode     = .byCharWrapping
    }
}
// MARK: - setConstraints

extension MainScrolView {
    
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
        
        //MARK: ItemsScrollView
        
        addSubview(contentView)
        
        contentView.addSubview(itemsScrollView)
        NSLayoutConstraint.activate(
            [itemsScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
             itemsScrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
             itemsScrollView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                  constant: 90),
             itemsScrollView.heightAnchor.constraint(equalToConstant:  UIScreen.main.bounds.size.height / 3)
            ]
        )
        
        //MARK: Title
        
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate(
            [titleLabel.topAnchor.constraint(equalTo: itemsScrollView.bottomAnchor,
                                             constant: 5),
             titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                 constant: 10),
             titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                  constant: -10),
             titleLabel.heightAnchor.constraint(equalToConstant: 50)
            ]
        )
        
        //MARK: ShopImage
        
        contentView.addSubview(shopImageView)
        shopImageView.addConstraint(shopImageViewHeightConstraint!)
        NSLayoutConstraint.activate(
            [shopImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                constant: 5),
             shopImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                    constant: 10),
             shopImageView.widthAnchor.constraint(equalToConstant: 100)
            ]
        )
        
        //MARK: Price
        
        contentView.addSubview(priceLabel)
        NSLayoutConstraint.activate(
            [priceLabel.topAnchor.constraint(equalTo: shopImageView.bottomAnchor,
                                             constant: 10),
             priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                 constant: 10)
            ]
        )
        
        //MARK: Cashback
        
        contentView.addSubview(cashbackLabel)
        NSLayoutConstraint.activate(
            [cashbackLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor,
                                                constant: 10),
             cashbackLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                    constant: 10)
            ]
        )
        
        contentView.addSubview(cashbackButton)
        NSLayoutConstraint.activate(
            [cashbackButton.topAnchor.constraint(equalTo: cashbackLabel.bottomAnchor,
                                                 constant: 5),
             cashbackButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                     constant: 10),
            ]
        )
        
        //MARK: Timecashback
        
        contentView.addSubview(timeCashbackLabel)
        NSLayoutConstraint.activate(
            [timeCashbackLabel.topAnchor.constraint(equalTo: cashbackButton.bottomAnchor,
                                                    constant: 10),
             timeCashbackLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                        constant: 10)
            ]
        )
        
        contentView.addSubview(dayCountLabel)
        NSLayoutConstraint.activate(
            [dayCountLabel.topAnchor.constraint(equalTo: timeCashbackLabel.bottomAnchor,
                                                constant: 5),
             dayCountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                    constant: 10)
            ]
        )
        
        //MARK: Terms
        
        contentView.addSubview(termsLabel)
        NSLayoutConstraint.activate(
            [termsLabel.topAnchor.constraint(equalTo: dayCountLabel.bottomAnchor,
                                             constant: 10),
             termsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                 constant: 10)
            ]
        )
        
        contentView.addSubview(firstTermsCashbackLabel)
        NSLayoutConstraint.activate(
            [firstTermsCashbackLabel.topAnchor.constraint(equalTo: termsLabel.bottomAnchor,
                                                          constant: 10),
             firstTermsCashbackLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                              constant: 10)
            ]
        )
        
        contentView.addSubview(firstTermsDiscribeLabel)
        NSLayoutConstraint.activate(
            [firstTermsDiscribeLabel.topAnchor.constraint(equalTo: termsLabel.bottomAnchor,
                                                          constant: 10),
             firstTermsDiscribeLabel.leadingAnchor.constraint(equalTo: firstTermsCashbackLabel.trailingAnchor,
                                                              constant: 2),
             firstTermsDiscribeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                               constant: -10)
            ]
        )
        
        contentView.addSubview(termsTableView)
        termsTableView.addConstraint(termsTableViewHeightConstraint!)
        NSLayoutConstraint.activate(
            [termsTableView.topAnchor.constraint(equalTo: firstTermsDiscribeLabel.bottomAnchor,
                                                 constant: 2),
             termsTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                     constant: 10),
             termsTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                      constant: -10),
            ]
        )
        
        
        contentView.addSubview(expandButton)
        NSLayoutConstraint.activate(
            [expandButton.topAnchor.constraint(equalTo: termsTableView.bottomAnchor,
                                               constant: 5),
             expandButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                   constant: 10),
             expandButton.heightAnchor.constraint(equalToConstant: 30)
            ]
        )
    }
}


