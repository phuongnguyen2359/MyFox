//
//  Series.swift
//  MyFox
//
//  Created by Chris on 4/7/17.
//  Copyright © 2017 RMIT. All rights reserved.
//

import Foundation

class Series: Media {
    var id: String?
    var name: String?
    var cover: String?
    
    required init(dictionary: [String : AnyObject]) {
        self.id = dictionary["s_id"] as? String
        self.name = dictionary["name"] as? String
        self.cover = dictionary["cover"] as? String
    }
}
