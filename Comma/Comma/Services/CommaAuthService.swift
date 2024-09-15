//
//  CommaAuthService.swift
//  Comma
//
//  Created by Period Sis. on 3/7/21.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class CommaAuthService {
    
    let activityView = CommaActivityView()
    let mainVC : UIViewController!
    
    
    
    
    
    init(mainVC: UIViewController?) {
        self.mainVC = mainVC
    }
    
//MARK: Navigation
    
    func navigateToNextView(viewController: UIViewController) {
        
        activityView.stopAnimating()
        guard let uid = Auth.auth().currentUser?.uid else {return}
        setupUserData(uid)
        mainVC.navigationController?.pushViewController(viewController, animated: true)
        
        
    }
    

//MARK: - Signing Up Methods
    
    func authenticateNewUser(username: String, _ email: String, _ password: String,  completion: @escaping (_ error: String?) -> Void) {
        activityView.startAnimating()
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            if let err = error {
                
                self.activityView.stopAnimating()
                return completion(err.localizedDescription)
                
            }
            guard let uid = result?.user.uid else {return completion("Error: There was a problem with obtaining the uid")}
            
            
            
            let data: [String: Any] = ["username": username, "email": email, "password": password]
            
            self.addNewUserData(uid, data) { (error) in
                
                if let err = error {
                    return completion(err.localizedDescription)
                }
            }
            
            
        }
        
        
    }
    
    func addNewUserData(_ uid: String, _ data: [String: Any], completion: @escaping (_ error: Error?) -> Void) {
        
        let userRef = Database.database().reference().child("users").child(uid)
        
        userRef.updateChildValues(data) { (error, dataRef) in
            
            if let err = error {
                return completion(err)
            }
            
            self.navigateToNextView(viewController: OnboardingVC())
            
            
        }
   
    }
    
//MARK: - Signing in Methods
    
    
    func loginUser(email: String, password: String, completion: @escaping (_ error:Error?) -> Void) {
        
        activityView.startAnimating()
        Auth.auth().signIn(withEmail: email, password: password) { (dataResult, error) in
            if let error = error {
                self.activityView.stopAnimating()
                return completion(error)
            } else {
                
                self.navigateToNextView(viewController: TabBarController())
                self.activityView.stopAnimating()
                
                
            }
            
            
        }
        
        
        
    }
    
//MARK: - Setting up user data for current user
    
    
    func setupUserData(_ uid: String) {
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            
            guard let shot = snapshot.value as? [String: AnyObject] else {return}
            CurrentUser.uid = uid
            CurrentUser.username = shot["username"] as? String
            CurrentUser.email = shot["email"] as? String
            CurrentUser.numOfPads = shot["numOfPads"] as? String
            print(CurrentUser.numOfPads)
            CurrentUser.numOfTamps = shot["numOfTamp"] as? String
            CurrentUser.numOfCups = shot["numOfCups"] as? String
            CurrentUser.numOfOthers = shot["numOfOthers"] as? String
            
            if CurrentUser.uid == nil{
                do{
                    try Auth.auth().signOut()
                    
                }catch{
                    
                }
            }
            
        }
        
        
    }
    
    
    func checkEmail(_ emailAddress: String, completion: @escaping (_ error: String?) -> Void) {
        activityView.startAnimating()
        Auth.auth().fetchSignInMethods(forEmail: emailAddress) { (providers, error) in
            self.activityView.stopAnimating()
            if providers != nil {
                return completion("This email has already been used.")
            }
            
            if error != nil {
                
                return completion(error?.localizedDescription)
                
            }
        }
        
        
        
    }
    
    func checkUsername(_ username: String, _ uid: String, completion: @escaping (_ error: String?) -> Void) {
        
        let ref = Database.database().reference()
        ref.child("users").child(uid).queryOrdered(byChild: "username").queryEqual(toValue: username).observeSingleEvent(of: .value) { (snapshot) in
            
            if snapshot.exists() {
                
                return completion(nil)
                
            } else {
                
                return completion("This username is taken")
                
            }
            
        }
    }
    
    
}

