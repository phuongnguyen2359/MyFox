//
//  Movie.swift
//  MyFox
//
//  Created by Chris on 4/7/17.
//  Copyright © 2017 RMIT. All rights reserved.
//

import Foundation

class Movie: Media {
    
    var id: String?
    var name: String?
    var cover: String?
    var imdb_rating: Float?
    
    required init(dictionary: [String : AnyObject]) {
        self.id = dictionary["m_id"] as? String
        self.name = dictionary["name"] as? String
        self.cover = dictionary["cover"] as? String
        self.imdb_rating = dictionary["imdb_rating"] as? Float
    }
}
