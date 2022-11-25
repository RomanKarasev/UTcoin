//
//  SignInView.swift
//  UTcoin
//
//  Created by Роман Карасёв on 22.11.2022.
//

import UIKit

//MARK: - SignInView

class SignInView: UIView {
    
    // MARK: Properties
    
    //MARK: Labels
    
    private let descriptionLabel = UILabel(text: Constants.Strings.signInVCDescription,
                                           font: .systemFont(ofSize: 14))
    private let clueLabel        = UILabel(text: Constants.Strings.signInVCClueLabel,
                                           font: .systemFont(ofSize: 12))
    
    private let instuctionLabel  = UILabel(text: Constants.Strings.signInVCInstruction,
                                           font: .systemFont(ofSize: 12, weight: .bold))
    //MARK: TextViews
    
    let numberTextField: UITextField = {
        let textField                                       = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder                               = "+79001112233"
        textField.borderStyle                               = .roundedRect
        textField.keyboardType                              = .phonePad
        return textField
    }()
    
    private let agreementTextView: UITextView = {
        let textView = UITextView()
        
        textView.text                                      = Constants.Strings.signInVCTextViewText
        textView.textColor                                 = .label
        textView.font                                      = .systemFont(ofSize: 13)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let onwardsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Далее", for: .normal)
        button.backgroundColor                           = #colorLiteral(red: 0.9137255549, green: 0.9137255549, blue: 0.9137255549, alpha: 1)
        button.layer.cornerRadius                        = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor(hexString: "#7D7D7D"), for: .normal)
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
        descriptionLabel.numberOfLines = .zero
        instuctionLabel.numberOfLines  = .zero
    }
    
    // MARK: setConstraints
    private func setConstraints() {
        addSubview(descriptionLabel)
        NSLayoutConstraint.activate(
            [descriptionLabel.topAnchor.constraint(equalTo: topAnchor,
                                                   constant: 160),
             descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                       constant: 20),
             descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                        constant: -20)
            ]
        )
        
        addSubview(clueLabel)
        NSLayoutConstraint.activate(
            [clueLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor,
                                            constant: 20),
             clueLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                constant: 20)
            ]
        )
        
        addSubview(numberTextField)
        NSLayoutConstraint.activate(
            [numberTextField.topAnchor.constraint(equalTo: clueLabel.bottomAnchor,
                                                  constant: 10),
             numberTextField.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                      constant: 20),
             numberTextField.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                       constant: -20),
             numberTextField.heightAnchor.constraint(equalToConstant: 50)
            ]
        )
        
        addSubview(instuctionLabel)
        NSLayoutConstraint.activate(
            [instuctionLabel.topAnchor.constraint(equalTo: numberTextField.bottomAnchor,
                                                  constant: 10),
             instuctionLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                      constant: 20),
             instuctionLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                       constant: -20)
            ]
        )
        
        addSubview(onwardsButton)
        NSLayoutConstraint.activate(
            [onwardsButton.topAnchor.constraint(equalTo: instuctionLabel.bottomAnchor,
                                                constant: 10),
             onwardsButton.centerXAnchor.constraint(equalTo: centerXAnchor),
             onwardsButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 100),
             onwardsButton.heightAnchor.constraint(equalToConstant: 50)
            ]
        )
        
        addSubview(agreementTextView)
        NSLayoutConstraint.activate(
            [agreementTextView.topAnchor.constraint(equalTo: onwardsButton.bottomAnchor,
                                                    constant: 10),
             agreementTextView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                        constant: 20),
             agreementTextView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                         constant: -20),
             agreementTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 100 )
            ]
        )
    }
}

