//
//  SignInVC.swift
//  Comma
//
//  Created by Period Sis. on 3/7/21.
//

import UIKit

class SignInVC: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    let activityView = CommaActivityView()
    
    private lazy var authService: CommaAuthService = {
        let service = CommaAuthService(mainVC: self)
        
        return service
        
        
    }()
    
    private lazy var backButton: UIButton = {
      let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "back button"), for: .normal)
        button.tag = 0
        button.addTarget(self, action: #selector(buttonHandler(sender:)), for: .touchUpInside)
        
        return button
        
    }()
    
    private lazy var header: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.text = "SIGN IN"
        label.font = .poppins48Bold
        label.textColor = .primaryMaroon
        label.numberOfLines = 1
        
        return label
        
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 30
        stackView.addArrangedSubview(emailField)
        stackView.addArrangedSubview(passwordField)
        
        
        return stackView
        
    }()
    
    private lazy var emailField: UITextField = {
        let field = UITextField().styleAccountField(placeholder: "Email...")
        field.translatesAutoresizingMaskIntoConstraints = false
        field.autocorrectionType = .no
        field.delegate = self
        
        return field
        
    }()
    
    private lazy var passwordField: UITextField = {
        let field = UITextField().styleAccountField(placeholder: "Password...")
        field.isSecureTextEntry = true
        field.translatesAutoresizingMaskIntoConstraints = false
        field.autocorrectionType = .no
        field.delegate = self
        
        return field
        
    }()
    
    private lazy var signInButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SIGN IN", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.poppins14Bold
        button.backgroundColor = UIColor.primaryMaroon
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.primaryMaroon.cgColor
        button.layer.shadowOpacity = 0.24
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 10
        button.tag = 1
        button.addTarget(self, action: #selector(buttonHandler(sender:)), for: .touchUpInside)
        
        return button
        
        
    }()
    
    private lazy var errorMessage: UILabel = {
       let label = UILabel()
       
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 0
        label.textColor = .primaryRed
        label.font = .poppins12Bold
        label.numberOfLines = 0
        
       return label
        
    }()
    
    
//MARK: - Textfield Functionality
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
    private func checkTextfields() -> String? {
        
        var message = ""
            
        //Check if there are any empty fields present
        
        if emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                
            print("Error: Not all fields have been filled yet.")
            message = "*Please make sure to fill in all fields"
            
                
        } else if emailField.text?.contains("@") != true {
            
            print("Error: Email is not valid")
            message = "*Email is not valid"
            
            
            
        }
                

        return message
    
            
    }
    
    @objc private func buttonHandler(sender:UIButton) {
        
        switch sender.tag {
        
        case 0:
            navigationController?.popViewController(animated: true)
            
        case 1:
            print("Sign in button tapped")
            
            errorMessage.alpha = 1
            errorMessage.text = checkTextfields()
            
            //Authentication
            guard let email = emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {return}
            guard let password = passwordField.text else {return}
            authService.loginUser(email: email, password: password) { (error) in
                
                if self.errorMessage.text == "" && error != nil {
                    
                    self.errorMessage.text = error?.localizedDescription
                }
            }
            
        default:
            break
            
        }
        
        
    }
    
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(backButton)
        backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        backButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.12).isActive = true
        backButton.heightAnchor.constraint(equalTo: backButton.widthAnchor).isActive = true
        
        view.addSubview(header)
        header.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 16).isActive = true
        header.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 55).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85).isActive = true
        
        view.addSubview(errorMessage)
        errorMessage.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 4).isActive = true
        errorMessage.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        errorMessage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        
        view.addSubview(signInButton)
        signInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        signInButton.topAnchor.constraint(equalTo: errorMessage.bottomAnchor, constant: 25).isActive = true
        signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
    }
    


}
