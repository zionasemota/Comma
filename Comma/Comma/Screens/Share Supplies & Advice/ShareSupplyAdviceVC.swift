//
//  ShareSupplyAdviceVC.swift
//  Comma
//
//  Created by Period Sis. on 3/9/21.
//

import UIKit
import FirebaseDatabase



class ShareSupplyAdviceVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postCollectionView.delegate = self
        postCollectionView.dataSource = self
        queryAllPosts()
        configureUI()
        
        
       
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.postCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        backBlurView.isHidden = true
        pickTypeView.isHidden = true
        queryAllPosts()
        
    }
    
    var currentUrlNumber = Int()
    
    var posts = [Post]() {
        
        didSet {
                postCollectionView.reloadData()
                
            }
    }
    
    var networking = ShareSupplyNetworking()
    var activityView = CommaActivityView()
    
    
    
//MARK: CUSTOM UIVIEW POPUP FUNCTIONS
    
    private lazy var backBlurView: UIView = {
        let mainView = UIView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        mainView.layer.masksToBounds = true
        mainView.isHidden = true
        return mainView
        
    }()
    
    private lazy var pickTypeView: UIView = {
        let mainView = UIView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.backgroundColor = .white
        mainView.layer.masksToBounds = false
        mainView.clipsToBounds = false
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowRadius = 3
        mainView.layer.shadowOpacity = 0.4
        mainView.layer.cornerRadius = 15
        mainView.isHidden = true
        
        return mainView
        
    }()
    

    
    private lazy var exitButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "exit out"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tag = 2
        button.addTarget(self, action: #selector(buttonHandler(sender:)), for: .touchUpInside)
        
        return button
        
    }()
    
    
    private lazy var questionLabel: UILabel = {
       let label = UILabel()
        label.font = .poppins14Reg
        label.textColor = .black
        label.text = "What type of post would you like to make?"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.sizeToFit()
        
        return label
        
    }()
    
    private lazy var buttonOne: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("General Post", for: .normal)
        button.titleLabel?.font = .poppins14Reg
        button.titleLabel?.textColor = .white
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .primaryRed
        button.layer.cornerRadius = 10
        button.imageView?.contentMode = .scaleAspectFill
        button.tag = 3
        button.addTarget(self, action: #selector(buttonHandler(sender:)), for: .touchUpInside)
        
        return button
        
    }()
    
    
    private lazy var buttonTwo: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Supply Sharing", for: .normal)
        button.titleLabel?.font = .poppins14Reg
        button.titleLabel?.textColor = .white
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .primaryRed
        button.layer.cornerRadius = 10
        button.imageView?.contentMode = .scaleAspectFill
        button.tag = 4
        button.addTarget(self, action: #selector(buttonHandler(sender:)), for: .touchUpInside)
        
        return button
        
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        stackView.addArrangedSubview(buttonOne)
        stackView.addArrangedSubview(buttonTwo)
        
        
        return stackView
       
        
        
    }()
    
    // ---------------------------------------------------------------------------------------------------------------------------------------------------- //
    
    private lazy var backButton: UIButton = {
      let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "back button"), for: .normal)
        button.tag = 0
        button.addTarget(self, action: #selector(buttonHandler(sender:)), for: .touchUpInside)
        button.sizeToFit()
        button.imageView?.contentMode = .scaleAspectFill
        
        return button
        
    }()
    
    private lazy var addPostButton: UIButton = {
      let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "add post"), for: .normal)
        button.tag = 1
        button.addTarget(self, action: #selector(buttonHandler(sender:)), for: .touchUpInside)
        button.sizeToFit()
        
        return button
        
    }()
    
    private lazy var pageHeading: UILabel = {
      let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .poppins36Bold
        label.textColor = .black
        label.text = "Comma Feed"
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        
        return label
        
    }()
    
    
    private lazy var subHeading: UILabel = {
      let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .poppins10Reg
        label.textColor = .gray
        label.text = "Connect with other users within a community where you can share anything about your period and get access to various period supples"
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        
        return label
        
    }()
    private lazy var postCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.collectionViewLayout.invalidateLayout()
        layout.estimatedItemSize = CGSize(width: collectionView.frame.width - 20, height: 200)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: "periodPost")
        
        
        return collectionView
        
    }()
    
    private lazy var postView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        
        return view
        
        
        
    }()
    
    
    
    @objc func buttonHandler(sender:UIButton) {
        
        switch sender.tag {
        
        case 0://go back
            navigationController?.popViewController(animated: true)
        
        case 1://add post
            
            questionLabel.text = "What type of post would you like to make?"
            buttonOne.setTitle("General Post", for: .normal)
            buttonTwo.setTitle("Supply Sharing", for: .normal)
            
            pickTypeView.isHidden = false
            backBlurView.isHidden = false
            
        case 2://exit popup
            pickTypeView.isHidden = true
            backBlurView.isHidden = true
            
        case 3://picked buttonOne
        
            switch buttonOne.titleLabel?.text {
            
            case "General Post":
                let vc = CreateNewPostVC(PostType: .periodPost)
                navigationController?.pushViewController(vc, animated: true)
                break
                
            case .none:
                break
            case .some(_):
                break
            }
            
        case 4: //picked buttonTwo
            
            switch buttonTwo.titleLabel?.text {
            
           case "Supply Sharing":
                let vc = CreateNewPostVC(PostType: .supplyPost)
                navigationController?.pushViewController(vc, animated: true)
                break
                
            case .none:
                break
            case .some(_):
                break
            }
        
            
            
    
        
        default:
            break
        }
        
    }
    
   
        
    
    

    
    //MARK: TABLE VIEW FUNCTIONS
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = postCollectionView.dequeueReusableCell(withReuseIdentifier: "periodPost", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        
        cell.layoutIfNeeded()
        
        
        Database.database().reference().child("users").child(post.userUID ?? "").observeSingleEvent(of: .value) { (snap) in
            
            guard let shot = snap.value as? [String:AnyObject] else {return}
            
            let username = shot["username"] as? String ?? ""
            
            cell.usernameLabel.text = "@\(username)"
            
            cell.contactButton.tag = indexPath.row
            cell.contactButton.addAction(UIAction(title: "Click Me", handler: { _ in
                
                self.questionLabel.text = "How would you like to donate money to this user?"
                self.buttonOne.setTitle("Contact Through Email", for: .normal)
                self.buttonTwo.setTitle("Donate to GoFundMe", for: .normal)
                
                self.pickTypeView.isHidden = false
                self.backBlurView.isHidden = false
                
                self.buttonOne.addAction(UIAction(title: "emailOption", handler: { (_) in
                    
                    if self.buttonOne.titleLabel?.text == "Contact Through Email" {
                        let email = self.posts[indexPath.row].emailInfo!
                        if let url = URL(string: "mailto:\(email)") {
                            UIApplication.shared.open(url)
                        }
                    }
                    
                }), for: .touchUpInside)
                
                self.buttonTwo.addAction(UIAction(title: "gofundOption", handler: { (_) in
                    if self.buttonTwo.titleLabel?.text == "Donate to GoFundMe" {
                        
                        
                        self.openURL(self.posts[indexPath.row].goFundInfo!)
                    }
                    
                }), for: .touchUpInside)
                
                
            }), for: .touchUpInside)
            

        }
        cell.postDescription.text = post.postDescription ?? ""
        
        //fetches date from database
        if let datePosted =  post.datePosted {
            
            let convertedDate = datePosted.stringToDate(date: datePosted)
            print(convertedDate)
            
            //gets current date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            let currentDate = dateFormatter.date(from: dateFormatter.string(from: Date()))
            
            if let yearsLabel = currentDate?.years(from: convertedDate),
               let daysLabel = currentDate?.days(from: convertedDate),
               let hourLabel = currentDate?.hours(from: convertedDate),
               let minutesLabel = currentDate?.minutes(from: convertedDate),
               let secondsLabel = currentDate?.seconds(from: convertedDate) {
                
                
                if yearsLabel != 0 {
                    
                    cell.timeAgoLabel.text = "Posted \(yearsLabel) years ago"
                    
                    
                } else if daysLabel != 0 {
                    
                    cell.timeAgoLabel.text = "Posted \(daysLabel) days ago"
                    
                    
                } else if hourLabel != 0 {
                    
                    cell.timeAgoLabel.text = "Posted \(hourLabel) hours ago"
                    
                    
                } else if minutesLabel != 0 {
                    
                    cell.timeAgoLabel.text = "Posted \(minutesLabel) minutes ago"
                    
                    
                } else if secondsLabel != 0 {
                    
                    cell.timeAgoLabel.text = "Posted \(secondsLabel) seconds ago"
                    
                }
                
                
                
            }
            
        }
        
        
        
        
       
        
        
        
        let postType = post.postType
        
        switch postType {
        
        case "periodPost":
            cell.postTypeBanner.setImage(UIImage(named: "period post banner"), for: .normal)
            cell.contactButton.isHidden = true
            
        case "supplyPost":
            cell.postTypeBanner.setImage(UIImage(named: "supply sharing banner"), for: .normal)
            cell.contactButton.isHidden = false
            
        default:
            break
            
        }
        
        
        print("The cell height \(cell.frame.height) and width \(cell.frame.width)")
        
        
        
        
        
        return cell
    }
    
    func openURL(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            
            return
        }
        UIApplication.shared.open(url, completionHandler: { success in
            if success {
                print("opened")
            } else {
                print("failed")
                // showInvalidUrlAlert()
            }
        })
    }
    
    private func queryAllPosts() {
        self.activityView.startAnimating()
        networking.getPosts { (postList) in
            self.activityView.stopAnimating()
            
            self.posts = postList
            
            DispatchQueue.main.async {
                self.postCollectionView.reloadData()
            
            }
            
        }
        
    }
  
    private func configureUI() {
        
        
        view.backgroundColor = .white
        print(posts.count)
        
        view.addSubview(backButton)
        backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        backButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.12).isActive = true
        backButton.heightAnchor.constraint(equalTo: backButton.widthAnchor).isActive = true
        
        view.addSubview(addPostButton)
        addPostButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13).isActive = true
        addPostButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        addPostButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1).isActive = true
        addPostButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1).isActive = true
        
        view.addSubview(pageHeading)
        pageHeading.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        pageHeading.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 15).isActive = true
        pageHeading.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        
        view.addSubview(subHeading)
        subHeading.leadingAnchor.constraint(equalTo: pageHeading.leadingAnchor).isActive = true
        subHeading.topAnchor.constraint(equalTo: pageHeading.bottomAnchor, constant: 8).isActive = true
        subHeading.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.88).isActive = true
        
        
        view.addSubview(postCollectionView)
        postCollectionView.topAnchor.constraint(equalTo: subHeading.bottomAnchor, constant: 20).isActive = true
        postCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        postCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        postCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        //FOR CUSTOM POPUP
        
    
        view.addSubview(backBlurView)
        backBlurView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backBlurView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backBlurView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backBlurView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        view.addSubview(pickTypeView)
        pickTypeView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pickTypeView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        pickTypeView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        pickTypeView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.32).isActive = true
        
        pickTypeView.addSubview(exitButton)
        exitButton.topAnchor.constraint(equalTo: pickTypeView.topAnchor, constant: 15).isActive = true
        exitButton.trailingAnchor.constraint(equalTo: pickTypeView.trailingAnchor, constant: -15).isActive = true
        exitButton.widthAnchor.constraint(equalTo: pickTypeView.widthAnchor, multiplier: 0.08).isActive = true
        exitButton.heightAnchor.constraint(equalTo: exitButton.widthAnchor).isActive = true
        
        pickTypeView.addSubview(questionLabel)
        questionLabel.topAnchor.constraint(equalTo: exitButton.bottomAnchor, constant: 10).isActive = true
        questionLabel.centerXAnchor.constraint(equalTo: pickTypeView.centerXAnchor).isActive = true
        questionLabel.widthAnchor.constraint(equalTo: pickTypeView.widthAnchor, multiplier: 0.82).isActive = true
        
        pickTypeView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20).isActive = true
        stackView.centerXAnchor.constraint(equalTo: pickTypeView.centerXAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: pickTypeView.widthAnchor, multiplier: 0.83).isActive = true
        stackView.heightAnchor.constraint(equalTo: pickTypeView.heightAnchor, multiplier: 0.4).isActive = true
        
        //________________________________________________________________________________________________________________________________________________________
        
        
       
        
        
        
        
        
        
        
        
    }

}
