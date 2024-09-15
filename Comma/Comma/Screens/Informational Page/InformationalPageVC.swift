//
//  InformationalPageVC.swift
//  Comma
//
//  Created by Period Sis. on 3/7/21.
//

import UIKit
import FirebaseAuth

class InformationalPageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()

        // Do any additional setup after loading the view.
    }
    
    private lazy var signOutButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .primaryRed
        button.setTitle("SIGN OUT", for: .normal)
        button.titleLabel?.font = .poppins12Reg
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 10
        button.titleLabel?.textAlignment = .center
        button.sizeToFit()
        button.tag = 0
        button.addTarget(self, action: #selector(buttonHandler(sender:)), for: .touchUpInside)
        
        return button
        
    }()
 
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(signOutButton)
        signOutButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.17).isActive = true
        signOutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        signOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        
        
    }
    
    @objc private func buttonHandler(sender: UIButton) {
        
        switch sender.tag {
        
        case 0:
            
            do {
                try Auth.auth().signOut()
                let vc = UINavigationController(rootViewController: IntroPageVC())
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true, completion: nil)
                
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
            
            
        
        default:
            break
        }
        
        
    }

 
}
