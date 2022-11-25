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
        view = signInView
    }
    
    //MARK: objcMethods
    
    @objc func onwardsButtonTapped() {
        number = signInView.numberTextField.text!
        let vc = ConfirmationViewController()
        Parser.signIn(number: number) { data in
            
            guard let currentNumber = data.normalizedPhone else { return }
            vc.number = currentNumber
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func closeButtonTapped() {
        
    }
    
    // MARK: - Private Methods
    private func setView() {
        title = "Войти"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: Constants.Images.closeBarItem,
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(closeButtonTapped))
        navigationController?.navigationBar.tintColor = Constants.Colors.mainColor
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func addTargetToButtons() {
        signInView.onwardsButton.addTarget(self,
                                           action: #selector(onwardsButtonTapped), for: .touchUpInside)
    }
    
    private func setDelegates() {
        signInView.numberTextField.delegate = self
    }
}

//MARK: - UITextFieldDelegate

extension SignInViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        signInView.onwardsButton.backgroundColor = Constants.Colors.mainColor
        signInView.onwardsButton.setTitleColor(.white, for: .normal)
        return true
    }
}

