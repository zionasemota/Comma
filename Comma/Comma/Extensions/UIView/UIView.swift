//
//  UIView.swift
//  Comma
//
//  Created by Period Sis. on 3/8/21.
//

import UIKit

extension UIView {
    
    func styleCounterView(nameOfView: UILabel, textfield: UITextField) {
        backgroundColor = .primaryRed
        layer.cornerRadius = 15
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameOfView)
        nameOfView.translatesAutoresizingMaskIntoConstraints = false
        nameOfView.sizeToFit()
        nameOfView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        nameOfView.topAnchor.constraint(equalTo: topAnchor, constant: 28).isActive = true
        nameOfView.font = .poppins18Bold
        nameOfView.textColor = .white
        addSubview(textfield)
        textfield.smallRoundedTextfield(view: self)
        textfield.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25).isActive = true
        textfield.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -26).isActive = true
        
        
    }
    
    func fillSuperview(withConstant constant: CGFloat = 0) {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
          [leadingAnchor.constraint(
            equalTo: superview.leadingAnchor,
            constant: constant),
           topAnchor.constraint(
            equalTo: superview.topAnchor,
            constant: constant),
           trailingAnchor.constraint(
            equalTo: superview.trailingAnchor,
            constant: -constant),
           bottomAnchor.constraint(
            equalTo: superview.bottomAnchor,
            constant: -constant)]
        )
      }
    
    
    
    
}
