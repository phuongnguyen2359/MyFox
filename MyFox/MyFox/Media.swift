//
//  Media.swift
//  MyFox
//
//  Created by Chris on 4/7/17.
//  Copyright © 2017 RMIT. All rights reserved.
//

import Foundation

enum MediaType : String {
    case Movie = "movies"
    case Series = "series"
    
    func cellIdentifier() -> String {
        switch self {
        case .Movie:
            return String("MovieCell")
        case .Series:
            return String("SeriesCell")
        }
    }
}

protocol Media : Parsable {
    var name: String? {get set}
    var cover: String? {get set}
    var id: String? {get set}
}
