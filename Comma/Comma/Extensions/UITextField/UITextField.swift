//
//  UIView.swift
//  Comma
//
//  Created by Period Sis. on 3/7/21.
//

import Foundation
import UIKit

extension UITextField {
    
    func styleAccountField(placeholder: String) -> UITextField {
        let field = UITextField()
        field.clipsToBounds = false
        field.backgroundColor = .white
        field.layer.masksToBounds = false
        field.heightAnchor.constraint(equalToConstant: 60).isActive = true
        field.textColor = .black
        field.layer.cornerRadius = 20
        field.font = .poppins14Reg
        field.layer.borderWidth = 1
        field.borderStyle = .none
        field.layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
        field.layer.shadowOffset = CGSize(width: 3, height: 3)
        field.layer.shadowColor = UIColor.gray.cgColor
        field.layer.shadowRadius = 5
        field.layer.shadowOpacity = 0.2
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: field.frame.height))
        field.leftViewMode = .always
        field.attributedPlaceholder = NSAttributedString(string: placeholder,
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderColor])
        
        
        return field
        
    }
    
    func smallRoundedTextfield(view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.cornerRadius = 15
        font = .poppins18Bold
        textColor = .gray
        textAlignment = .center
        widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.22).isActive = true
        tintColor = .gray
        attributedPlaceholder = NSAttributedString(string: "#  ",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        keyboardType = .numberPad
        
        
    }
    
    
}
