//
//  ViewController.swift
//  BankeyDemo
//
//  Created by Arken Sarsenov on 10.06.2022.
//

import UIKit
protocol LogoutDelegate: AnyObject {
    func didLogout()
}

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}

class LoginViewController: UIViewController {
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let loginView = LoginView()
    let signInButton = UIButton()
    let errorMessageLabel = UILabel()
    
    weak var delegate: LoginViewControllerDelegate?
    
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        signInButton.configuration?.showsActivityIndicator = false
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
            delegate?.didLogin()
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
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.text = "Bankey"
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        subtitleLabel.adjustsFontForContentSizeCategory = true
        subtitleLabel.numberOfLines = 0
        subtitleLabel.text = "Your premium source for all things banking!"
        
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
        
        //Titels
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height/4),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subtitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 3),
            subtitleLabel.leftAnchor.constraint(equalToSystemSpacingAfter: view.leftAnchor, multiplier: 2),
            view.rightAnchor.constraint(equalToSystemSpacingAfter: subtitleLabel.rightAnchor, multiplier: 2)
        ])
        
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
