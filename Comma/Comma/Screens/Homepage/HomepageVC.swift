//
//  HomepageVC.swift
//  Comma
//
//  Created by Period Sis. on 3/7/21.
//

import UIKit

class HomepageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        // Do any additional setup after loading the view.
    }
    
    private lazy var header: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome Home!"
        label.font = .poppins36Bold
        label.sizeToFit()
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        
        return label
        
    }()
    
    private lazy var currentSuppliesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Current Supplies"
        label.font = .poppins14Reg
        label.textColor = .gray
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        
        return label
        
    }()
    
    private lazy var manageSuppliesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Manage Current Period Supplies", for: .normal)
        button.titleLabel?.font = .poppins18Bold
        button.titleLabel?.textColor = .white
        button.setImage(UIImage(named: "manage-icon"), for: .normal)
        button.backgroundColor = .primaryRed
        button.layer.cornerRadius = 15
        button.layer.shadowColor = UIColor.primaryRed.cgColor
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 3
        button.tag = 0
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 40, bottom: 50, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 60, left: -25, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(buttonHandler(sender:)), for: .touchUpInside)
        
        return button
        
    }()
    
    private lazy var supplySharingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Supply Sharing"
        label.font = .poppins14Reg
        label.textColor = .gray
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        
        return label
        
    }()
    
    private lazy var supplySharingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let yourAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.poppins18Bold]
        let yourOtherAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.poppins14Med]

        let partOne = NSMutableAttributedString(string: "Share Supplies", attributes: yourAttributes)
        let partTwo = NSMutableAttributedString(string: "\n-Share period supplies with people from all around the world", attributes: yourOtherAttributes)
        
        let combination = NSMutableAttributedString()

        combination.append(partOne)
        combination.append(partTwo)
        button.setAttributedTitle(combination, for: .normal)
        button.titleLabel?.font = .poppins18Bold
        button.titleLabel?.textColor = .white
        button.titleLabel?.numberOfLines = 0
        button.setImage(UIImage(named: "share-icon"), for: .normal)
        button.backgroundColor = .primaryRed
        button.layer.cornerRadius = 15
        button.layer.shadowColor = UIColor.primaryRed.cgColor
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 3
        button.tag = 1
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 40, bottom: 60, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 65, left: -55, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(buttonHandler(sender:)), for: .touchUpInside)
        
        return button
        
    }()
    
    private lazy var donateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Donate"
        label.font = .poppins14Reg
        label.textColor = .gray
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        
        return label
        
    }()
    
    private lazy var donateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Donate Towards Ending Period Poverty", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.font = .poppins16Bold
        button.titleLabel?.textColor = .white
        button.setImage(UIImage(named: "donate-icon"), for: .normal)
        button.backgroundColor = .primaryRed
        button.layer.cornerRadius = 15
        button.layer.shadowColor = UIColor.primaryRed.cgColor
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 3
        button.tag = 2
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 40, bottom: 45, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 60, left: -25, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(buttonHandler(sender:)), for: .touchUpInside)
        
        return button
        
    }()
    
    
    @objc func buttonHandler(sender:UIButton) {
        
        switch  sender.tag {
        case 0: //manage supplies button
            let vc = ManageSuppliesVC()
            navigationController?.pushViewController(vc, animated: true)
            break
        case 1: //supply sharing button
            let vc = ShareSupplyAdviceVC()
            navigationController?.pushViewController(vc, animated: true)
            
            break
        case 2: //donate button
        
            if let url = URL(string: "https://period.org/donate") {
                UIApplication.shared.open(url)
                print("Navigated to period.org donate section")
            }
        
        default:
            break
        }
        
    }
    
    
    

    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(header)
        header.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.74).isActive = true
        header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        header.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        
        view.addSubview(currentSuppliesLabel)
        currentSuppliesLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.28).isActive = true
        currentSuppliesLabel.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 15).isActive = true
        currentSuppliesLabel.leadingAnchor.constraint(equalTo: header.leadingAnchor).isActive = true
        
        view.addSubview(manageSuppliesButton)
        manageSuppliesButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.87).isActive = true
        manageSuppliesButton.heightAnchor.constraint(equalTo:view.heightAnchor, multiplier: 0.17).isActive = true
        manageSuppliesButton.topAnchor.constraint(equalTo: currentSuppliesLabel.bottomAnchor, constant: 15).isActive = true
        manageSuppliesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(supplySharingLabel)
        supplySharingLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.28).isActive = true
        supplySharingLabel.topAnchor.constraint(equalTo: manageSuppliesButton.bottomAnchor, constant: 27).isActive = true
        supplySharingLabel.leadingAnchor.constraint(equalTo: currentSuppliesLabel.leadingAnchor).isActive = true
        
        view.addSubview(supplySharingButton)
        supplySharingButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.87).isActive = true
        supplySharingButton.heightAnchor.constraint(equalTo:view.heightAnchor, multiplier: 0.18).isActive = true
        supplySharingButton.topAnchor.constraint(equalTo: supplySharingLabel.bottomAnchor, constant: 15).isActive = true
        supplySharingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(donateLabel)
        donateLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.28).isActive = true
        donateLabel.topAnchor.constraint(equalTo: supplySharingButton.bottomAnchor, constant: 27).isActive = true
        donateLabel.leadingAnchor.constraint(equalTo: supplySharingLabel.leadingAnchor).isActive = true
        
        view.addSubview(donateButton)
        donateButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.87).isActive = true
        donateButton.heightAnchor.constraint(equalTo:view.heightAnchor, multiplier: 0.11).isActive = true
        donateButton.topAnchor.constraint(equalTo: donateLabel.bottomAnchor, constant: 15).isActive = true
        donateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        
        
        
        
        
        
        
    }
    
    

}
