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
}

protocol Media : Parsable {
    var name: String? {get set}
    var cover: String? {get set}
    var id: String? {get set}
}
