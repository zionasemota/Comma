//
//  SignUpVC.swift
//  Comma
//
//  Created by Period Sis. on 3/7/21.
//

import UIKit

class SignUpVC: UIViewController, UITextFieldDelegate {

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
        label.text = "SIGN UP"
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
        stackView.addArrangedSubview(usernameField)
        stackView.addArrangedSubview(emailField)
        stackView.addArrangedSubview(passwordField)
        stackView.addArrangedSubview(confirmPasswordField)
        
        return stackView
        
    }()
    
    private lazy var usernameField: UITextField = {
        let field = UITextField().styleAccountField(placeholder: "Username...")
        field.translatesAutoresizingMaskIntoConstraints = false
        field.autocorrectionType = .no
        field.delegate = self
        
        return field
        
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
    
    private lazy var confirmPasswordField: UITextField = {
        let field = UITextField().styleAccountField(placeholder: "Confirm Password...")
        field.isSecureTextEntry = true
        field.translatesAutoresizingMaskIntoConstraints = false
        field.autocorrectionType = .no
        field.delegate = self
        
        return field
        
    }()
    
    private lazy var signupButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SIGN UP", for: .normal)
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
        
       return label
        
    }()
    
    
//MARK: - Textfield Functionalities
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        moveTextField(textField, moveDistance: -70, up: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        moveTextField(textField, moveDistance: -70, up: false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
        }

        // Move the text field in a pretty animation!
    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    private func checkTextfields() -> String? {
        
        var message = ""
            
        //Check if there are any empty fields present
        
        if emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            usernameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            confirmPasswordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                
            print("Error: Not all fields have been filled yet.")
            message = "*Please make sure to fill in all fields"
            
                
                
        } else if (usernameField.text?.trimmingCharacters(in: .whitespacesAndNewlines).count)! < 6 {
            
            //Check if username is at least 6 characters
                 
                 print("Error: Username needs to have at least 6 characters")
                 message = "*Username needs to have at least 6 characters"
                 
        } else if emailField.text?.contains("@") != true {
            
            print("Error: Email is not valid")
            message = "*Email is not valid"
            
            
        } else if passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != confirmPasswordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            
        //Check if passwords match in both fields
            
            print("Error: Passwords do not match")
            message = "*Passwords do not match"
            
            
        } else if (passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines).count)! < 8 {
            
       //Check if password is at least 8 characters
            
            print("Error: Passwords needs to have at least 8 characters")
            message = "*Password needs to have at least 8 characters"
            
        }
                

        return message
    
            
    }
    
    
    
    @objc func buttonHandler(sender:UIButton) {
        
        switch sender.tag {
        
        case 0:
            navigationController?.popViewController(animated: true)
            
        case 1:
            print("Sign up button tapped")
            
            let checker = checkTextfields()
            errorMessage.alpha = 1
            
            if checker != "" {
                
                errorMessage.text = checker
                
                
                
            } else {
            
            guard let email = emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                  let password = passwordField.text,
                  let username = usernameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {return}
            authService.activityView.startAnimating()
            authService.authenticateNewUser(username: username, email, password) { (error) in
                
                self.errorMessage.text = error
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
        
        view.addSubview(signupButton)
        signupButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        signupButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        signupButton.topAnchor.constraint(equalTo: errorMessage.bottomAnchor, constant: 25).isActive = true
        signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
    }
    
    
    
    
}
