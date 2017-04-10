//
//  Parsable.swift
//  MyFox
//
//  Created by Chris on 4/7/17.
//  Copyright © 2017 RMIT. All rights reserved.
//

import Foundation

protocol Parsable {
    init(dictionary: [String : AnyObject])
}

class Parser {
    static func parseNumber<T>() -> T? {
        return nil
    }
    
    static func parseObject<T: Parsable>(jsonObject: Any) -> T? {
        
        guard let validJsonObject = jsonObject as? [String: AnyObject] else {
            return nil
        }
        return T.init(dictionary: validJsonObject)
    }
    
    static func parseArray<T: Parsable>(jsonArray: Any?) -> [T]? {
        
        guard let validJsonArray = jsonArray as? [[String: AnyObject]] else {
            return nil
        }
        
        var parseResult = [T]()
        
        for jsonObject in validJsonArray {
            if let validObject : T = parseObject(jsonObject: jsonObject) {
                parseResult.append(validObject)
            }
        }
        
        return parseResult
    }
}
