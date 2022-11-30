//
//  SignInViewController.swift
//  UTcoin
//
//  Created by Роман Карасёв on 22.11.2022.
//

import UIKit

//MARK: - SignInViewController

class SignInViewController: UIViewController {
    
    // MARK: Properties
    
    var number = ""
    var currentNumber = ""
    let userDefaults = UserDefaults.standard
    
    //MARK: Views
    
    private let signInView = SignInView()
    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        addTargetToButtons()
        setDelegates()
    }
    
    override func loadView() {
        super.loadView()
    }
    
    //MARK: objcMethods
    
    @objc func onwardsButtonTapped() {
        if number == "" {
            isTextIsValid()
        } else {
            let vc = ConfirmationViewController()
            vc.number = number
            DispatchQueue.main.async {
                vc.confirmationView.numberLabel.text = self.userDefaults.string(forKey: "normalizedPhone")
            }
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func closeButtonTapped() {
        
    }
    
    // MARK: - Private Methods
    private func setView() {
        view.backgroundColor = .systemBackground
        title = "Войти"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: Constants.Images.closeBarItem,
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(closeButtonTapped))
        navigationController?.navigationBar.tintColor = Constants.Colors.mainColor
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(signInView)
        NSLayoutConstraint.activate(
            [signInView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                             constant: 10),
             signInView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             signInView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             signInView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
        )
    }
    
    private func addTargetToButtons() {
        signInView.onwardsButton.addTarget(self,
                                           action: #selector(onwardsButtonTapped), for: .touchUpInside)
    }
    
    private func setDelegates() {
        signInView.numberTextField.delegate = self
    }
    
    private func isTextIsRight(textField: UITextField, range: NSRange, string: String, maxLength: Int) -> Bool {
        guard let text = textField.text, let rangeText = Range(range, in: text) else { return false}
        
        let updateText = text.replacingCharacters (in: rangeText, with: string)
        if updateText.count == maxLength, updateText.isValid(validTypes: .code) {
            return true
        } else {
            return false
        }
    }
    
    private func getData(number: String) {
        let vc = ConfirmationViewController()
        Parser.signIn(number: number) { data in
            guard let currentNumber = data.normalizedPhone else { return }
            vc.number = currentNumber
            self.userDefaults.setValue(currentNumber, forKey: "normalizedPhone")
            self.userDefaults.setValue(number, forKey: "number")
            DispatchQueue.main.async {
                vc.confirmationView.numberLabel.text = currentNumber
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func isTextIsValid() {
        
        if signInView.numberTextField.text != nil {
            guard let text = signInView.numberTextField.text else { return }
            if text.isValid(validTypes: .number) {
                number = text
                getData(number: text)
            } else {
                setAlert(title: Constants.Strings.numberError, viewController: self)
            }
        }
    }
}

//MARK: - UITextFieldDelegate

extension SignInViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if isTextIsRight(textField: textField, range: range, string: string, maxLength: 10) {
            
            signInView.onwardsButton.backgroundColor = Constants.Colors.mainColor
            signInView.onwardsButton.setTitleColor(.white, for: .normal)
        } else {
            signInView.onwardsButton.backgroundColor = #colorLiteral(red: 0.9137255549, green: 0.9137255549, blue: 0.9137255549, alpha: 1)
            signInView.onwardsButton.setTitleColor(UIColor(hexString: "#7D7D7D"), for: .normal)
        }
        return true
    }
}

