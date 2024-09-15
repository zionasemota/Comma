//
//  CommaActivityView.swift
//  Comma
//
//  Created by Period Sis. on 3/7/21.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class CommaActivityView {
    
    let window = UIApplication.shared.windows[0]
    var blurBackground = UIVisualEffectView()
    
    private lazy var loadView: UIView = {
        let loadView = UIView()
        loadView.translatesAutoresizingMaskIntoConstraints = false
        loadView.backgroundColor = .white
        loadView.layer.masksToBounds = true
        loadView.layer.cornerRadius = 5
        return loadView
        
    }()
    
    
    private lazy var loadLabel: UILabel = {
       let label = UILabel()
        label.font = .poppins12Bold
        label.textColor = .primaryRed
        label.text = "Loading..."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
        
    }()
    
    private lazy var loadingAnimation: NVActivityIndicatorView = {
        let activity = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 700, height: 50), type: .pacman, color: .primaryRed, padding: 0)
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.color = .primaryRed
        
        
        
        return activity
    }()

    
    
   func startAnimating() {
    window.addSubview(blurBackground)
    blurBackground.frame = window.frame
    blurBackground.effect = UIBlurEffect(style: .dark)
    configureLayout()
    loadingAnimation.startAnimating()
    print(loadingAnimation.frame.width)
    
        
        
    }
    
    func stopAnimating() {
        
        blurBackground.removeFromSuperview()
        loadView.removeFromSuperview()
        
        
        
    }
    
    
    private func configureLayout() {
        
        let margins = window.layoutMarginsGuide
        
        let screenWidth = window.widthAnchor
        
        
        blurBackground.contentView.addSubview(loadView)
        loadView.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        loadView.centerYAnchor.constraint(equalTo: margins.centerYAnchor).isActive = true
        loadView.widthAnchor.constraint(equalTo: screenWidth, multiplier: 0.64).isActive = true
        loadView.heightAnchor.constraint(equalToConstant: 133).isActive = true
        
        loadView.addSubview(loadingAnimation)
        loadingAnimation.centerXAnchor.constraint(equalTo: loadView.centerXAnchor).isActive = true
        loadingAnimation.centerYAnchor.constraint(equalTo: loadView.centerYAnchor, constant: -20).isActive = true
        
        loadingAnimation.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        loadView.addSubview(loadLabel)
        loadLabel.bottomAnchor.constraint(equalTo: loadView.bottomAnchor, constant: -20).isActive = true
        loadLabel.centerXAnchor.constraint(equalTo: loadView.centerXAnchor).isActive = true
        
        
    }
   
 
    
}
