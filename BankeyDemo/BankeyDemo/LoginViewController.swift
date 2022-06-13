//
//  ViewController.swift
//  BankeyDemo
//
//  Created by Arken Sarsenov on 10.06.2022.
//

import UIKit

class LoginViewController: UIViewController {
    let loginView = LoginView()
    let signInButton = UIButton()
    let errorMessageLabel = UILabel()
    
    var username: String? {
        return loginView.usernameTextField.text
    }
    
    var password: String? {
        return loginView.passwordTextField.text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    //MARK: - Actions
   @objc private func signInTapped() {
       errorMessageLabel.isHidden = true
       login()
    }
    
    private func login() {
        guard let username = username, let password = password else {
            assertionFailure("Username / Password should neve be nil")
            return
        }
        if username.isEmpty || password.isEmpty {
            return configureMessage(withMessage: "Username / password can not be blank")
        }
        if username == "Kevin" && password == "Welcome" {
            signInButton.configuration?.showsActivityIndicator = true
        } else {
            configureMessage(withMessage: "username / password incorrect")
        }
    }
    
    private func configureMessage(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
}

extension LoginViewController {
    private func style() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.isHidden = true
    }
    
    private func layout() {
        
        //Login View
        view.addSubview(loginView)
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
        ])
        
        //SignIn button
        view.addSubview(signInButton)
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        //Error Message Label Constraints
        view.addSubview(errorMessageLabel)
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalTo: signInButton.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: signInButton.trailingAnchor)
        ])
        
    }
}
