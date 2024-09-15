//
//  OnboardingVC.swift
//  Comma
//
//  Created by Period Sis. on 3/7/21.
//

import UIKit
import paper_onboarding

class OnboardingVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPaperOnboardingView()
        configureUI()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private lazy var getStartedText: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Get Started"
        label.font = .poppins20Reg
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private lazy var forwardButton: UIButton = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "forward button"), for: .normal)
        button.addTarget(self, action: #selector(buttonHandler(sender:)), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var continuationStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.addArrangedSubview(getStartedText)
        stackView.addArrangedSubview(forwardButton)
        stackView.isHidden = true
        
        return stackView
        
        
    }()
    
    private func configureUI() {
        
        //Setting up Get Started Button
        view.addSubview(continuationStackView)
        continuationStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        continuationStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        forwardButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.11).isActive = true
        forwardButton.heightAnchor.constraint(equalTo: forwardButton.widthAnchor).isActive = true
        
        
        
        
    }
    
    @objc private func buttonHandler(sender:UIButton) {
        
        switch sender.tag {
        
        case 0:
            let homeVc = TabBarController()
            navigationController?.pushViewController(homeVc, animated: true)
            
        default:
            break
            
            
        }
        
    }
    
    private func setupPaperOnboardingView() {
            let onboarding = PaperOnboarding()
            onboarding.delegate = self
            onboarding.dataSource = self
            onboarding.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(onboarding)
        
        for attribute: NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom] {
            let constraint = NSLayoutConstraint(item: onboarding,
                                                attribute: attribute,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: attribute,
                                                multiplier: 1,
                                                constant: 0)
            view.addConstraint(constraint)
        }
        
        
    }
    
    fileprivate let items = [
     OnboardingItemInfo(informationImage: UIImage(named: "connectImage")!,
                        title: "Connect",
                        description: "\nConnect with other people that are\nready to recieve or give period products\nto someone in need of them.",
                        pageIcon: UIImage(),
                        color: UIColor.white,
                        titleColor: UIColor.primaryRed,
                        descriptionColor: UIColor.primaryRed,
                        titleFont: UIFont.poppins48Bold,
                        descriptionFont: UIFont.poppins18Reg),

        OnboardingItemInfo(informationImage: UIImage(named: "identifyImage")!,
                                    title: "Identify",
                              description: "\nIdentify a different range of period\nproducts using our period product image\nrecognition system.",
                              pageIcon: UIImage(),
                                    color: UIColor.white,
                               titleColor: UIColor.primaryRed,
                         descriptionColor: UIColor.primaryRed,
                                titleFont: UIFont.poppins48Bold,
                          descriptionFont: UIFont.poppins18Reg),

        OnboardingItemInfo(informationImage: UIImage(named: "discoverImage")!,
                                 title: "Discover",
                           description: "\nDiscover and learn more about the\npresence of period poverty in different\nareas including schools and homeless\ncommunities.",
                           pageIcon: UIImage(),
                                 color: UIColor.white,
                            titleColor: UIColor.primaryRed,
                      descriptionColor: UIColor.primaryRed,
                             titleFont: UIFont.poppins48Bold,
                       descriptionFont: UIFont.poppins18Reg)
     ]
    
    
    
    
    
}

extension OnboardingVC: PaperOnboardingDataSource {

    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return items[index]
    }

    func onboardingItemsCount() -> Int {
        return 3
    }
    
    func onboardingPageItemColor(at index: Int) -> UIColor {
        return [UIColor.primaryRed, UIColor.primaryRed, UIColor.primaryRed][index]
   }
    
    
    

}

extension OnboardingVC: PaperOnboardingDelegate {

    
    func onboardingWillTransitonToIndex(_ index: Int) {
        if index == 0 || index == 1 {
            
            continuationStackView.isHidden = true
           
            
        } else {
            
            continuationStackView.isHidden = false
        }
        
        
        }
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        
        item.imageView?.contentMode = .scaleAspectFill
        
    
    
    }
}
