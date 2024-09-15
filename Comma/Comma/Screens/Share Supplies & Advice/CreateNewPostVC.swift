//
//  CreateNewPostVC.swift
//  Comma
//
//  Created by Period Sis. on 3/10/21.
//

import UIKit
import UITextView_Placeholder
import FirebaseDatabase

enum PostType {
    case supplyPost
    case periodPost
}

class CreateNewPostVC: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()

        // Do any additional setup after loading the view.
    }
    
    var postType: PostType
    var fieldsEmpty = false
    
    init(PostType: PostType) {
        self.postType = PostType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var cancelButton: UIButton = {
      let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Cancel Button"), for: .normal)
        button.tag = 0
        button.imageView?.contentMode = .scaleAspectFill
        button.sizeToFit()
        button.addTarget(self, action: #selector(buttonHandler(sender:)), for: .touchUpInside)
        
        return button
        
    }()
    
    private lazy var addANewPostTitle: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.text = "Add a New Post"
        label.font = .poppins18Bold
        label.textColor = .black
        label.numberOfLines = 1
        label.sizeToFit()
        
        return label
        
    }()
    
    private lazy var subheading: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.text = "Create a new post to add to the supply feed for others to see"
        label.font = .poppins12Italic
        label.textColor = .gray
        label.numberOfLines = 1
        label.sizeToFit()
        
        return label
        
    }()
    
    private lazy var newPostView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        view.clipsToBounds = false
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowRadius = 3
        
        return view
        
        
        
    }()
    
    private lazy var goFundTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.black.cgColor
        field.layer.cornerRadius = 15
        field.attributedPlaceholder = NSAttributedString(string: "Enter GoFundMe Link Here(include http/https)...",
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.poppins12Reg])
        field.font = .poppins12Reg
        field.textColor = .black
        field.autocorrectionType = .no
        field.backgroundColor = .white
        field.clipsToBounds = false
        field.layer.masksToBounds = false
        field.layer.shadowColor = UIColor.lightGray.cgColor
        field.layer.shadowRadius = 3
        field.delegate = self
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: field.frame.height))
        field.leftViewMode = .always
        
        return field
        
    }()
    
    private lazy var emailTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.black.cgColor
        field.layer.cornerRadius = 15
        field.attributedPlaceholder = NSAttributedString(string: "Enter Email Here...",
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.poppins12Reg])
        field.backgroundColor = .white
        field.autocorrectionType = .no
        field.clipsToBounds = false
        field.layer.masksToBounds = false
        field.font = .poppins12Reg
        field.textColor = .black
        field.layer.shadowColor = UIColor.lightGray.cgColor
        field.layer.shadowRadius = 3
        field.delegate = self
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: field.frame.height))
        field.leftViewMode = .always
        
        return field
        
    }()
    
    
    
    private lazy var postStatus: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .primaryRed
        button.layer.cornerRadius = 10
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .poppins9SemiBold
        button.titleLabel?.textColor = .white
        
        
        switch postType {
        case .periodPost:
            button.setTitle("General Post", for: .normal)
        case .supplyPost:
            button.setTitle("Supply Sharing", for: .normal)
        }
        
        return button
        
        
    }()
    
    private lazy var usernameDisplay: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        if let username = CurrentUser.username {
            label.text = "@\(username)"
        }
        label.font = .poppins11SemiBold
        label.textColor = .black
        label.numberOfLines = 1
        label.sizeToFit()
        
        return label
        
    }()
    
    private lazy var enterPostDescription: UITextView = {
       let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderColor = .none
        textView.placeholder = "Start a conversation here..."
        textView.placeholderColor = .gray
        textView.font = .poppins12Reg
        textView.textColor = .black
        textView.sizeToFit()
        textView.addDoneButton()
        textView.backgroundColor = .white
        
        return textView
        
    }()
    
    private lazy var postButton: UIButton = {
       
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .primaryRed
        if let username = CurrentUser.username {
            button.setTitle("Post as @\(username)", for: .normal)
        }
        button.titleLabel?.font = .poppins18SemiBold
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 10
        button.clipsToBounds = false
        button.layer.masksToBounds = false
        button.layer.shadowColor = UIColor.darkGray.cgColor
        button.layer.shadowRadius = 3
        button.layer.shadowOpacity = 0.6
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.sizeToFit()
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.tag = 1
        button.addTarget(self, action: #selector(buttonHandler(sender:)), for: .touchUpInside)
        return button
    }()
    
    @objc private func buttonHandler(sender:UIButton) {
        
        switch sender.tag {
        case 0:
            
            navigationController?.popViewController(animated: true)
            
        case 1: //post button
        
            checkTextView()
            
            if fieldsEmpty == false {
                
                addPostToDatabase()
                navigationController?.popViewController(animated: true)
                
                
            }
               
        default:
            break
                
            }
        
            
            
       
        }
        
    
    private func addPostToDatabase() {
        
        if let newPostID = Database.database().reference().child("feed").childByAutoId().key {
 
            let postData: [String: Any] = ["postDescription": enterPostDescription.text ?? "", "postID": newPostID, "userUID": CurrentUser.uid ?? "", "datePosted": getCurrentTime() ?? "", "postType": String(describing: postType), "emailInfo": emailTextField.text?.trimmingCharacters(in: .whitespaces) ?? "", "goFundMeInfo": goFundTextField.text?.trimmingCharacters(in: .whitespaces) ?? ""]
            
            Database.database().reference().child("feed").child(CurrentUser.uid).child(newPostID).updateChildValues(postData)
            
            
                
                
                
                
            }
        
        
    }
    
    private func getCurrentTime() -> String? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        return dateFormatter.string(from: Date())
        
    }

    
    private func checkTextView() {
        
        switch postType {
        
        case .supplyPost:
            
            fieldsEmpty = false
            
            if enterPostDescription.text.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                goFundTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                
                fieldsEmpty = true
                let fieldsAlert = UIAlertController(title: "Missing Fields", message: "Please make sure to fill all fields before posting.", preferredStyle: UIAlertController.Style.alert)
                fieldsAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(fieldsAlert, animated: true, completion: nil)
                
            }
            
        case .periodPost:
            fieldsEmpty = false
            if enterPostDescription.text.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                
                fieldsEmpty = true
                let fieldsAlert = UIAlertController(title: "Missing Fields", message: "Please make sure to fill all fields before posting.", preferredStyle: UIAlertController.Style.alert)
                fieldsAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(fieldsAlert, animated: true, completion: nil)
                
            }
            
        default:
            break
            
        
        }
        
        
        
    }
    
    private func configureUI() {
        
        
        view.backgroundColor = .white
        
        view.addSubview(cancelButton)
        cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        cancelButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.06).isActive = true
        
        view.addSubview(addANewPostTitle)
        addANewPostTitle.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 20).isActive = true
        addANewPostTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        addANewPostTitle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.34).isActive = true
        
        view.addSubview(subheading)
        subheading.topAnchor.constraint(equalTo: addANewPostTitle.bottomAnchor, constant: 5).isActive = true
        subheading.leadingAnchor.constraint(equalTo: addANewPostTitle.leadingAnchor).isActive = true
        subheading.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.83).isActive = true
        
        view.addSubview(newPostView)
        newPostView.topAnchor.constraint(equalTo: subheading.bottomAnchor, constant: 30).isActive = true
        newPostView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newPostView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.83).isActive = true
        newPostView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.18).isActive = true
        
        newPostView.addSubview(postStatus)
        postStatus.widthAnchor.constraint(equalTo: newPostView.widthAnchor, multiplier: 0.27).isActive = true
        postStatus.heightAnchor.constraint(equalTo: newPostView.heightAnchor, multiplier: 0.13).isActive = true
        postStatus.topAnchor.constraint(equalTo: newPostView.topAnchor, constant: 5).isActive = true
        postStatus.trailingAnchor.constraint(equalTo: newPostView.trailingAnchor, constant: -5).isActive = true
        
        newPostView.addSubview(usernameDisplay)
        usernameDisplay.topAnchor.constraint(equalTo: newPostView.topAnchor, constant: 15).isActive = true
        usernameDisplay.leadingAnchor.constraint(equalTo: newPostView.leadingAnchor, constant: 15).isActive = true
        usernameDisplay.widthAnchor.constraint(equalTo: newPostView.widthAnchor, multiplier: 0.21).isActive = true
        
        newPostView.addSubview(enterPostDescription)
        enterPostDescription.bottomAnchor.constraint(equalTo: newPostView.bottomAnchor, constant: -5).isActive = true
        enterPostDescription.leadingAnchor.constraint(equalTo: usernameDisplay.leadingAnchor).isActive = true
        enterPostDescription.widthAnchor.constraint(equalTo: newPostView.widthAnchor, multiplier: 0.91).isActive = true
        enterPostDescription.heightAnchor.constraint(equalTo: newPostView.heightAnchor, multiplier: 0.75).isActive = true
        
        if postType == .periodPost {
        
            view.addSubview(postButton)
            postButton.topAnchor.constraint(equalTo: newPostView.bottomAnchor, constant: 30).isActive = true
            postButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            postButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.68).isActive = true
            postButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
            
        } else if postType == .supplyPost {
            
            view.addSubview(goFundTextField)
            goFundTextField.topAnchor.constraint(equalTo: newPostView.bottomAnchor, constant: 20).isActive = true
            goFundTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            goFundTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.83).isActive = true
            goFundTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
            
            view.addSubview(emailTextField)
            emailTextField.topAnchor.constraint(equalTo: goFundTextField.bottomAnchor, constant: 20).isActive = true
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.83).isActive = true
            emailTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
            
            view.addSubview(postButton)
            postButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 18).isActive = true
            postButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            postButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.68).isActive = true
            postButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
                
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }

}
