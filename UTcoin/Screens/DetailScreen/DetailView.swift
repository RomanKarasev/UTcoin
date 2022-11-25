//
//  DetailView.swift
//  UTcoin
//
//  Created by Роман Карасёв on 23.11.2022.
//

import UIKit

//MARK: - DetailView

class DetailView: UIView {
    
    //MARK: Views
    let mainScrollView = MainScrolView()
    
    //MARK: Buttons

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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - setConstraints

extension DetailView {
    
    private func setConstraints() {
        
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
        
        
        addSubview(mainScrollView)
        NSLayoutConstraint.activate(
            [mainScrollView.topAnchor.constraint(equalTo: topAnchor),
             mainScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
             mainScrollView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width),
             mainScrollView.bottomAnchor.constraint(equalTo: buyButton.topAnchor,
                                                    constant: -10)
            ]
        )
    }
}


