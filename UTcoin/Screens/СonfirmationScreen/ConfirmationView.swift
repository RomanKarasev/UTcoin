//
//  ConfirmationView.swift
//  UTcoin
//
//  Created by Роман Карасёв on 23.11.2022.
//


import UIKit

//MARK: - ConfirmationView

class ConfirmationView: UIView {
    
    // MARK: Properties
    
    //MARK: Texts
    
    private let instuctionLabel = UILabel(text: Constants.Strings.confirmationInstruction,
                                          font: .systemFont(ofSize: 14, weight: .bold))
    
    let errorLabel = UILabel(text: "", font: .systemFont(ofSize: 12))
    
    let numberTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "****"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }()
    
    //MARK: Buttons
    private let senderButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отправить код еще раз", for: .normal)
        button.setTitleColor(Constants.Colors.mainColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
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
        instuctionLabel.numberOfLines = .zero
        errorLabel.textColor = .red
        errorLabel.isHidden = true
    }
    
    // MARK: setConstraints
    private func setConstraints() {
        addSubview(instuctionLabel)
        NSLayoutConstraint.activate(
            [instuctionLabel.topAnchor.constraint(equalTo: topAnchor,
                                                  constant: 160),
             instuctionLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                      constant: 20),
             instuctionLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                       constant: -20)
            ]
        )
        
        addSubview(numberTextField)
        NSLayoutConstraint.activate(
            [numberTextField.topAnchor.constraint(equalTo: instuctionLabel.bottomAnchor,
                                                  constant: 10),
             numberTextField.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                      constant: 20),
             numberTextField.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                       constant: -20),
             numberTextField.heightAnchor.constraint(equalToConstant: 50)
            ]
        )
        
        addSubview(errorLabel)
        NSLayoutConstraint.activate(
            [errorLabel.topAnchor.constraint(equalTo: numberTextField.bottomAnchor,
                                             constant: 2),
             errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                 constant: 20)
            ]
        )
        
        addSubview(senderButton)
        NSLayoutConstraint.activate(
            [senderButton.topAnchor.constraint(equalTo: numberTextField.bottomAnchor,
                                               constant: 20),
             senderButton.centerXAnchor.constraint(equalTo: centerXAnchor),
             senderButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40),
             senderButton.heightAnchor.constraint(equalToConstant: 22)
            ]
        )
    }
}


