//
//  Category.swift
//  MyFox
//
//  Created by Chris on 4/7/17.
//  Copyright © 2017 RMIT. All rights reserved.
//

import Foundation

class Category : Parsable {
    
    var name: String?
    var type: MediaType?
    var feed: String?
    var mediaArray: [Media] = []
    
    required init(dictionary: [String : AnyObject]) {
        self.name = dictionary["name"] as? String
        self.feed = dictionary["feed"] as? String
        if let typeString = dictionary["type"] as? String {
            self.type = MediaType(rawValue: typeString)
        }
    }
    
    init() {
        
    }
}

