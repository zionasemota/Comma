//
//  PostCell.swift
//  Comma
//
//  Created by Period Sis. on 3/10/21.
//

import UIKit

class PostCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        setupElements()
        configureCellUI()
        
        
    }
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    var cellView = UIView()
    var usernameLabel = UILabel()
    var timeAgoLabel = UILabel()
    var postDescription = UILabel()
    var goFundLink = String()
    var email = String()
    var contactButton = UIButton()
    var postTypeBanner = UIButton()
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
            setNeedsLayout()
            layoutIfNeeded()
            let size = systemLayoutSizeFitting(layoutAttributes.size)
            var frame = layoutAttributes.frame
           // frame.size.width = layoutAttributes.size.width
            frame.size.height = ceil(size.height)
            layoutAttributes.frame = frame
            return layoutAttributes
        }
    
    
   
    
    
    
    
    private func setupElements() {
        
        
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.backgroundColor = .white
        cellView.layer.cornerRadius = 10
        cellView.layer.borderWidth = 1
        cellView.layer.borderColor = UIColor.black.cgColor
        
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.adjustsFontSizeToFitWidth = true
        usernameLabel.font = .poppins10SemiBold
        usernameLabel.textColor = .black
        usernameLabel.numberOfLines = 1
        usernameLabel.sizeToFit()
        
        timeAgoLabel.translatesAutoresizingMaskIntoConstraints = false
        timeAgoLabel.adjustsFontSizeToFitWidth = true
        timeAgoLabel.font = .poppins9Light
        timeAgoLabel.sizeToFit()
        timeAgoLabel.textColor = .black
        timeAgoLabel.numberOfLines = 1
        
        postDescription.translatesAutoresizingMaskIntoConstraints = false
        postDescription.font = .poppins13Reg
        postDescription.numberOfLines = 0
        postDescription.textAlignment = .left
        postDescription.textColor = .black
        postDescription.lineBreakMode = .byWordWrapping
        
        
        contactButton.translatesAutoresizingMaskIntoConstraints = false
        contactButton.setImage(UIImage(named: "contact-icon"), for: .normal)
        
        postTypeBanner.translatesAutoresizingMaskIntoConstraints = false
        postTypeBanner.sizeToFit()
        
        
        
        
        
    }
    
    
    private func configureCellUI() {
        backgroundColor = .white
        
                
        addSubview(cellView)
        cellView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cellView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        cellView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        cellView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        
       addSubview(usernameLabel)
        usernameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        usernameLabel.bottomAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        usernameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25).isActive = true
        
        addSubview(timeAgoLabel)
        timeAgoLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 0).isActive = true
        timeAgoLabel.bottomAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 20).isActive = true
        timeAgoLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor).isActive = true
        timeAgoLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3).isActive = true
        
        addSubview(postTypeBanner)
        postTypeBanner.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.33).isActive = true
        postTypeBanner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        postTypeBanner.topAnchor.constraint(equalTo: usernameLabel.topAnchor ).isActive = true
        
        addSubview(postDescription)
        postDescription.topAnchor.constraint(equalTo: timeAgoLabel.bottomAnchor, constant: 8).isActive = true
        postDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        postDescription.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor).isActive = true
        postDescription.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        postDescription.sizeToFit()
        
        
        addSubview(contactButton)
        contactButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 22).isActive = true
        contactButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
        contactButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2).isActive = true
        contactButton.heightAnchor.constraint(equalTo: contactButton.widthAnchor).isActive = true
        
     
        
        
        
    }
    
    
    
    
    
}
