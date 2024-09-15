//
//  ShareSupplyNetworking.swift
//  Comma
//
//  Created by Period Sis. on 3/16/21.
//

import Foundation
import UIKit
import FirebaseDatabase

class ShareSupplyNetworking {
    
    var postList = [String:Post]()
    var allPosts = [Post]()
    var userIdList = [String]()
    
    
    func setupPostData(withUserId id: String, completion: @escaping (_ postList: [String:Post]) -> Void) {
        
        Database.database().reference().child("feed").child(id).observeSingleEvent(of: .value) { (snap) in
            
            for child in snap.children {// child == postIds's
                let post = Post()
                guard let snapshot = child as? DataSnapshot else { return }
                guard let values = snapshot.value as? [String: Any] else { return }
                
                post.postID = snapshot.key
                post.postType = values["postType"] as? String
                post.postDescription = values["postDescription"] as? String
                post.goFundInfo = values["goFundMeInfo"] as? String
                post.emailInfo = values["emailInfo"] as? String
                post.datePosted = values["datePosted"] as? String
                post.userUID = id
                self.postList[post.postID!] = post
                
                
            }
            return completion(self.postList)
        }
        
        
        
        
    }
    
    
    func getPosts(completion: @escaping (_ allPosts: [Post]) -> Void) {
       
        Database.database().reference().child("feed").observeSingleEvent(of: .value) { (snap) in
            
            for child in snap.children {// child == userId's
                guard let snapshot = child as? DataSnapshot else { return }
                let userid = snapshot.key
                self.userIdList.append(userid)
            }
            
            for id in self.userIdList {
                
                self.setupPostData(withUserId: id) { listOfPosts in
                    
                    
                    let sortedList = Array(listOfPosts.values).sorted(by: { (post1, post2) -> Bool in
                        return post1.datePosted! > post2.datePosted!
                    })
                    
                    self.allPosts = sortedList
                    
                    return completion(self.allPosts)
                
                    
                }
                
                
            }
            
            
            
           
            
        }
        
        
        
        
    }
    
    
    
}
