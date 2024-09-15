//
//  CurrentUser.swift
//  Comma
//
//  Created by Period Sis. on 3/7/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CurrentUser {
    
    
    public static var username: String!
    
    public static var email: String!
    
    public static var numOfPads: String!
    
    public static var numOfTamps: String!
    
    public static var numOfCups: String!
    
    public static var numOfOthers: String!
    
    public static var uid: String!
    
    public static func refreshData() {
        guard let finaluid = Auth.auth().currentUser?.uid else {
            return
        }
        
        Database.database().reference().child("users").child(finaluid).observeSingleEvent(of: .value) { (snapshot) in
            
            guard let shot = snapshot.value as? [String: AnyObject] else {return}
            username = shot["username"] as? String
            email = shot["email"] as? String
            numOfPads = shot["numOfPads"] as? String
            numOfTamps = shot["numOfTamp"] as? String
            numOfCups = shot["numOfCups"] as? String
            numOfOthers = shot["numOfOthers"] as? String
            uid = finaluid
        
        }
    }
    

        
}

