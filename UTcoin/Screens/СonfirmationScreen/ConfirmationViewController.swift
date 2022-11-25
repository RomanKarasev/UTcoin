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
    
    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setDelegate()
    }
    
    
    // MARK: View life cycle
    
    override func loadView() {
        super.loadView()
        view = confirmationView
    }
    
    
    // MARK: - Private Methods
    
    private func setView() {
        title = Constants.Strings.confirmationVCTitle
        navigationController?.navigationBar.tintColor = Constants.Colors.mainColor
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setDelegate() {
        confirmationView.numberTextField.delegate = self
    }
}


//MARK: - UITextFieldDelegate

extension ConfirmationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength               = 4
        let currentString: NSString = textField.text! as NSString
        let newString: NSString     = currentString.replacingCharacters(in: range, with: string) as NSString
        verificationCode            = newString as String
        
        if newString.length == maxLength {
            
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
                        self.confirmationView.errorLabel.isHidden = false
                        self.confirmationView.errorLabel.text     = number.errorMessage
                    }
                }
            }
        }
        return true
    }
}
