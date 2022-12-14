//
//  TermsTableViewCell.swift
//  UTcoin
//
//  Created by Роман Карасёв on 23.11.2022.
//

import UIKit

// MARK: - TermsTableViewCell

final class TermsTableViewCell: UITableViewCell {
    
    static let identifier = "TermsTableViewCell"
    
    //MARK: Labels
    
    let cashbackLabel = UILabel(text: "",
                                font: .systemFont(ofSize: 12))
    
    let discribeLabel = UILabel(text: "",
                                font: .systemFont(ofSize: 12, weight: .bold))
    
    
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
        cashbackLabel.textColor                 = #colorLiteral(red: 0.9803285003, green: 0.3133740723, blue: 0.6123356819, alpha: 1)
        cashbackLabel.adjustsFontSizeToFitWidth = false
        cashbackLabel.sizeToFit()
        cashbackLabel.textAlignment = .right
        
        discribeLabel.contentMode   = .center
        discribeLabel.numberOfLines =  3
        discribeLabel.lineBreakMode = .byWordWrapping
    }
    
}

//MARK: - setConstraints

extension TermsTableViewCell {
    
    private func setConstraints() {
        
        addSubview(cashbackLabel)
        NSLayoutConstraint.activate(
            [cashbackLabel.topAnchor.constraint(equalTo: topAnchor),
             cashbackLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
             cashbackLabel.widthAnchor.constraint(equalToConstant: 75)
            ]
        )
        
        addSubview(discribeLabel)
        NSLayoutConstraint.activate(
            [discribeLabel.topAnchor.constraint(equalTo: topAnchor),
             discribeLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
             discribeLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
             discribeLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
            ]
        )
    }
}

