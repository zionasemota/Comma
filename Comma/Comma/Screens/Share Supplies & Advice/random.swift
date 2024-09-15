//
//  random.swift
//  Comma
//
//  Created by Period Sis. on 4/3/21.
//

import Foundation
import UIKit

class random: UIViewController {
    
    let periodPovertyLabel = UILabel()
    let appleButton = UIButton()
    let pastramiImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        setValues()
        setConstraints()
    }
    
    private func setValues() {
        periodPovertyLabel.translatesAutoresizingMaskIntoConstraints = false
        periodPovertyLabel.text = "#ENDPERIODPOVERTY"
        periodPovertyLabel.font = .poppins30Bold
        periodPovertyLabel.textColor = .black
        periodPovertyLabel.textAlignment = .center
        periodPovertyLabel.sizeToFit()
        
        appleButton.setTitle("Apple", for: .normal)
        appleButton.titleLabel?.textAlignment = .center
        appleButton.titleLabel?.textColor = .black
        appleButton.titleLabel?.font = .poppins7Reg
        appleButton.backgroundColor = .primaryRed
        appleButton.translatesAutoresizingMaskIntoConstraints = false
        appleButton.sizeToFit()
        appleButton.layer.cornerRadius = 10
        
        pastramiImage.image = UIImage(named: "pastrami burger")
        pastramiImage.translatesAutoresizingMaskIntoConstraints = false
        pastramiImage.layer.cornerRadius = 15
        
        //Set image maskToBounds to true in order to customize image (ex: corner radius)
        pastramiImage.layer.masksToBounds = true
        pastramiImage.contentMode = .scaleAspectFill
        pastramiImage.sizeToFit()
        
        
        
        
        
    }
    
    private func setConstraints() {
        view.addSubview(periodPovertyLabel)
        periodPovertyLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        periodPovertyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        periodPovertyLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.92).isActive = true
        
        view.addSubview(appleButton)
        appleButton.topAnchor.constraint(equalTo: periodPovertyLabel.bottomAnchor, constant: 15).isActive = true
        appleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        appleButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        
        view.addSubview(pastramiImage)
        pastramiImage.topAnchor.constraint(equalTo: appleButton.bottomAnchor, constant: 12).isActive = true
        
        //When using trailingAnchor, make constant negative
        pastramiImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        pastramiImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        pastramiImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.30).isActive = true
        
        
        
        
    }
    
    
    

    
    
}
