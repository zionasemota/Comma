//
//  IntroPageVC.swift
//  Comma
//
//  Created by Period Sis. on 3/6/21.
//

import UIKit

class IntroPageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
   
    
    private lazy var introImage: UIImageView = {
       
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "tree with girl")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
        
    }()
    
    private lazy var bottomFooterView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
        
    }()
    
    private lazy var footerBackground: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Bottom View")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
        
    }()
    
    private lazy var appTitle: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "COMMA"
        label.font = .poppins48Bold
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.textColor = .white
        
        return label
        
    }()
    
    private lazy var appDescription: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.font = .poppins18Med
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .white
        label.text = "Ending period poverty one step at\na time"
        
        return label
        
    }()
    
    private lazy var getStartedButton: UIButton = {
       
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("GET STARTED", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .poppins14Bold
        button.backgroundColor = .white
        button.titleLabel?.textColor = .black
        button.titleLabel?.tintColor = .black
        button.layer.cornerRadius = 25
        button.tag = 0
        button.addTarget(self, action: #selector(navHandler(sender:)), for: .touchUpInside)
        
        return button
        
        
    }()
    
    private lazy var signIn: UIButton = {
        let button = UIButton()
        let yourAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.poppins14Reg]
        let yourOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.poppins14Bold]

        let partOne = NSMutableAttributedString(string: "ALREADY HAVE AN ACCOUNT?", attributes: yourAttributes)
        let partTwo = NSMutableAttributedString(string: " LOG IN", attributes: yourOtherAttributes)
        
        let combination = NSMutableAttributedString()

        combination.append(partOne)
        combination.append(partTwo)
        
        button.setAttributedTitle(combination, for: .normal)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 1
        button.addTarget(self, action: #selector(navHandler(sender:)), for: .touchUpInside)
        return button
        
    }()
    
//MARK: Navigation
    
    @objc private func navHandler(sender:UIButton) {
        
        switch sender.tag {
        
        case 0:
            let vc = SignUpVC()
            navigationController?.pushViewController(vc, animated: true)
        
        case 1:
            let vc = SignInVC()
            navigationController?.pushViewController(vc, animated: true)
        
        default:
            break

        }
        
    }
    
    
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(introImage)
        introImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        introImage.heightAnchor.constraint(equalTo: introImage.widthAnchor).isActive = true
        introImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        introImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(bottomFooterView)
        bottomFooterView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        bottomFooterView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.54).isActive = true
        bottomFooterView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomFooterView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        bottomFooterView.addSubview(footerBackground)
        footerBackground.topAnchor.constraint(equalTo: bottomFooterView.topAnchor).isActive = true
        footerBackground.trailingAnchor.constraint(equalTo: bottomFooterView.trailingAnchor).isActive = true
        footerBackground.bottomAnchor.constraint(equalTo: bottomFooterView.bottomAnchor).isActive = true
        footerBackground.leadingAnchor.constraint(equalTo: bottomFooterView.leadingAnchor).isActive = true
        
        bottomFooterView.addSubview(appTitle)
        appTitle.topAnchor.constraint(equalTo: bottomFooterView.topAnchor, constant: 95).isActive = true
        appTitle.centerXAnchor.constraint(equalTo: bottomFooterView.centerXAnchor).isActive = true
        
        bottomFooterView.addSubview(appDescription)
        appDescription.topAnchor.constraint(equalTo: appTitle.bottomAnchor, constant: 18).isActive = true
        appDescription.centerXAnchor.constraint(equalTo: bottomFooterView.centerXAnchor).isActive = true
        appDescription.widthAnchor.constraint(equalTo: bottomFooterView.widthAnchor, multiplier: 0.75).isActive = true
        
        bottomFooterView.addSubview(getStartedButton)
        getStartedButton.topAnchor.constraint(equalTo: appDescription.bottomAnchor, constant: 25).isActive = true
        getStartedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        getStartedButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.91).isActive = true
        getStartedButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07).isActive = true
        
        bottomFooterView.addSubview(signIn)
        signIn.topAnchor.constraint(equalTo: getStartedButton.bottomAnchor, constant: 3).isActive = true
        signIn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }

}
