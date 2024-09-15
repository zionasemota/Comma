//
//  ManageSuppliesVC.swift
//  Comma
//
//  Created by Period Sis. on 3/8/21.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ManageSuppliesVC: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        
        

        // Do any additional setup after loading the view.
    }
    
  
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        setupPreviousValuesForVC()
       
        
        
        
    }
    
    let activityView = CommaActivityView()
   
    private lazy var backButton: UIButton = {
      let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "back button"), for: .normal)
        button.tag = 0
        button.addTarget(self, action: #selector(butnHandler(sender:)), for: .touchUpInside)
        
        return button
        
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
          button.translatesAutoresizingMaskIntoConstraints = false
          button.setImage(UIImage(named: "save-button"), for: .normal)
          button.tag = 1
        button.sizeToFit()
          button.addTarget(self, action: #selector(butnHandler(sender:)), for: .touchUpInside)
          
          return button
        
    }()
    
    private lazy var heading: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.text = "Current Supplies"
        label.font = .poppins36Bold
        label.textColor = .black
        label.numberOfLines = 1
        label.sizeToFit()
        
        return label
        
    }()
    
    private lazy var subheading: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Supplies You Have:"
        label.font = .poppins14Reg
        label.textColor = .gray
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        
        return label
        
    }()
    
    private lazy var padsView: UIView = {
       let mainview = UIView()
        mainview.styleCounterView(nameOfView: padsLabel, textfield: padsTextfield)
        
        return mainview
        
    }()
    
    private lazy var padsLabel: UILabel = {
        let label = UILabel()
        label.text = "Pads"
        
        return label
        
    }()
    
    private lazy var padsTextfield: UITextField = {
        let field = UITextField()
        field.delegate = self
        
        return field
        
    }()
    
    private lazy var tamponsView: UIView = {
       let mainview = UIView()
        mainview.styleCounterView(nameOfView: tamponsLabel, textfield: tamponsTextfield)
        
        return mainview
        
    }()
    
    private lazy var tamponsLabel: UILabel = {
        let label = UILabel()
        label.text = "Tampons"
        
        return label
        
    }()
    
    private lazy var tamponsTextfield: UITextField = {
        let field = UITextField()
        field.delegate = self
        
        return field
        
    }()
    
    private lazy var cupsView: UIView = {
       let mainview = UIView()
        mainview.styleCounterView(nameOfView: cupsLabel, textfield: cupsTextfield)
        
        return mainview
        
    }()
    
    private lazy var cupsLabel: UILabel = {
        let label = UILabel()
        label.text = "Menstrual\nCups"
        label.numberOfLines = 2
        
        return label
        
    }()
    
    private lazy var cupsTextfield: UITextField = {
        let field = UITextField()
        field.delegate = self
        
        return field
        
    }()
    
    private lazy var othersView: UIView = {
       let mainview = UIView()
        mainview.styleCounterView(nameOfView: othersLabel, textfield: othersTextfield)
        
        return mainview
        
    }()
    
    private lazy var othersLabel: UILabel = {
        let label = UILabel()
        label.text = "Other\nMaterials"
        label.numberOfLines = 2
        
        return label
        
    }()
    
    private lazy var othersTextfield: UITextField = {
        let field = UITextField()
        field.delegate = self
        
        return field
        
    }()
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
        }
    
    
    @objc private func butnHandler(sender:UIButton) {
        
        switch sender.tag {
        
        case 0://back button
            navigationController?.popViewController(animated: true)
            
        case 1: //save button
            saveUserSupplies()
            
        default:
            break
        }
        
    }
    
    private func setupPreviousValuesForVC() {
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        activityView.startAnimating()
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            
            guard let shot = snapshot.value as? [String: Any] else {return}
            
            if let pads = shot["numOfPads"] as? Int,
               let tamps = shot["numOfTamp"] as? Int,
               let cups = shot["numOfCups"] as? Int,
               let others = shot["numOfOthers"] as? Int {
                
    
                
                self.padsTextfield.text = String(pads)
                self.tamponsTextfield.text = String(tamps)
                self.cupsTextfield.text = String(cups)
                self.othersTextfield.text = String(others)
                self.activityView.stopAnimating()
                
                
            } else {
                
                self.activityView.stopAnimating()
                
            }
                
        
        }
        
        
        
        
    
}
    
    private func saveUserSupplies() {
        
        if padsTextfield.text != ""
           && tamponsTextfield.text != ""
           && cupsTextfield.text != ""
           && othersTextfield.text != "" {
            
            guard let numOfPads = padsTextfield.text,
                  let numOfTamp = tamponsTextfield.text,
                  let numOfCups = cupsTextfield.text,
                  let numOfOthers = othersTextfield.text else {return}
                  
            
            let data: [String: Any] = ["numOfPads": Int(numOfPads)!, "numOfTamp": Int(numOfTamp)!, "numOfCups": Int(numOfCups)!, "numOfOthers": Int(numOfOthers)!]
            
            let userRef = Database.database().reference().child("users").child(CurrentUser.uid)
            
            CurrentUser.numOfPads = numOfPads
            CurrentUser.numOfTamps = numOfTamp
            CurrentUser.numOfCups = numOfCups
            CurrentUser.numOfOthers = numOfOthers
            
            userRef.updateChildValues(data) { (error, dataRef) in
                
                if error != nil {
                    
                    print("There was an error updating this information into the database.")
                    
                }
                
                
                self.navigationController?.popViewController(animated: true)
                
            }
            
           
            
            
            
        } else {
            
            let fieldsAlert = UIAlertController(title: "Missing Fields", message: "Please make sure to fill all fields before saving.", preferredStyle: UIAlertController.Style.alert)
            fieldsAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(fieldsAlert, animated: true, completion: nil)
            
            
        }
        
        
        
        
        
        
        
    }
    
    private func configureUI() {
        
        view.backgroundColor = .white
        
        view.addSubview(backButton)
        backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        backButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.12).isActive = true
        backButton.heightAnchor.constraint(equalTo: backButton.widthAnchor).isActive = true
        
        view.addSubview(saveButton)
        saveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        saveButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1).isActive = true
        saveButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1).isActive = true
        
        
        view.addSubview(heading)
        heading.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 16).isActive = true
        heading.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        
        view.addSubview(subheading)
        subheading.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.28).isActive = true
        subheading.topAnchor.constraint(equalTo: heading.bottomAnchor, constant: 15).isActive = true
        subheading.leadingAnchor.constraint(equalTo: heading.leadingAnchor).isActive = true
        
        view.addSubview(padsView)
        padsView.topAnchor.constraint(equalTo: subheading.bottomAnchor, constant: 30).isActive = true
        padsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        padsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.35).isActive = true
        padsView.heightAnchor.constraint(equalTo: padsView.widthAnchor).isActive = true
        
        view.addSubview(tamponsView)
        tamponsView.topAnchor.constraint(equalTo: padsView.topAnchor).isActive = true
        tamponsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35).isActive = true
        tamponsView.widthAnchor.constraint(equalTo: padsView.widthAnchor).isActive = true
        tamponsView.heightAnchor.constraint(equalTo: padsView.heightAnchor).isActive = true
        
        view.addSubview(cupsView)
        cupsView.topAnchor.constraint(equalTo: padsView.bottomAnchor, constant: 30).isActive = true
        cupsView.leadingAnchor.constraint(equalTo: padsView.leadingAnchor).isActive = true
        cupsView.widthAnchor.constraint(equalTo: padsView.widthAnchor).isActive = true
        cupsView.heightAnchor.constraint(equalTo: padsView.heightAnchor).isActive = true
        
        view.addSubview(othersView)
        othersView.topAnchor.constraint(equalTo: cupsView.topAnchor).isActive = true
        othersView.trailingAnchor.constraint(equalTo: tamponsView.trailingAnchor).isActive = true
        othersView.widthAnchor.constraint(equalTo: padsView.widthAnchor).isActive = true
        othersView.heightAnchor.constraint(equalTo: padsView.heightAnchor).isActive = true
        
        
        
    }

   

}
