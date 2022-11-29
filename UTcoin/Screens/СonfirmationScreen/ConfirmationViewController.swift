//
//  ConfirmationViewController.swift
//  UTcoin
//
//  Created by Роман Карасёв on 23.11.2022.
//


import UIKit

//MARK: - ConfirmationViewController
class ConfirmationViewController: UIViewController {
    
    
    // MARK: Properties
    
    let confirmationView = ConfirmationView()
    var verificationCode = ""
    var number           = ""
    var errorText        = ""
    var stringNumber     = ""
    var counter          = 60
    
    
    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setDelegate()
        addTargetToButtons()
    }
    
    
    // MARK: View life cycle
    
    override func loadView() {
        super.loadView()
    }
    
    // MARK: @objc Methods
    
    @objc func senderButtonTapped() {
        
        if confirmationView.senderButton.titleLabel?.text == Constants.Strings.senderButtonMainText {
            Parser.signIn(number: number) { data in
                guard let currentNumber = data.normalizedPhone else { return }
                self.number = currentNumber
            }
            counter = 60
            updateCounter()
        }
    }
    
    @objc func updateCounter() {
        if counter > 0 {
            let buttonTitle = "Запросить код можно через \(counter) c."
            confirmationView.senderButton.setTitle(buttonTitle, for: .normal)
            confirmationView.senderButton.setTitleColor(.red, for: .normal)
            counter -= 1
        } else if counter == 0 {
            confirmationView.senderButton.setTitleColor(Constants.Colors.mainColor, for: .normal)
            confirmationView.senderButton.setTitle(Constants.Strings.senderButtonMainText, for: .normal)
        }
    }
    
    
    // MARK: Private Methods
    
    private func setView() {
        view.backgroundColor = .systemBackground
        title = Constants.Strings.confirmationVCTitle
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
        setNavController()
        
        view.addSubview(confirmationView)
        NSLayoutConstraint.activate(
            [confirmationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                   constant: 10),
             confirmationView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                       constant: 20),
             confirmationView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                        constant: -20),
             confirmationView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
        )
    }
    
    private func setNavController() {
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30, weight: .bold)]
        navigationController?.navigationBar.tintColor = Constants.Colors.mainColor
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setDelegate() {
        confirmationView.numberTextField.delegate = self
    }
    
    private func addTargetToButtons() {
        confirmationView.senderButton.addTarget(self, action: #selector(senderButtonTapped), for: .touchUpInside)
    }
}


//MARK: - UITextFieldDelegate

extension ConfirmationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength               = 4
        if let text = textField.text, let rangeText = Range(range, in: text) {
            let updateText = text.replacingCharacters (in: rangeText, with: string)
            
            if updateText.count == maxLength, updateText.isValid(validTypes: .code) {
                verificationCode = updateText
                textField.text = verificationCode
                textField.resignFirstResponder()
                Parser.verification(number: number, verificationCode: verificationCode) { number in
                    if number.successful == true {
                        DispatchQueue.main.async {
                            let vc = SearchViewController()
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    } else {
                        DispatchQueue.main.async {
                            guard let error = number.errorMessage else { return }
                            self.setAlert(title: error, viewController: self)
                        }
                    }
                }
            }
        }
        return true
    }
}
