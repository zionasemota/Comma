//
//  String.swift
//  Comma
//
//  Created by Period Sis. on 3/15/21.
//

import UIKit

extension String {
    
    
    func stringToDate(date: String) -> Date {
        
        let dateFormatter = DateFormatter()
       
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
        
        return dateFormatter.date(from: date)! 
        
        
    }
    
    
    
}
