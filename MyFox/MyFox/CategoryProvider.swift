//
//  CategoryProvider.swift
//  MyFox
//
//  Created by Chris on 4/7/17.
//  Copyright © 2017 RMIT. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

class CategoryProvider {
    
    let urlCategroy = "http://demo6492027.mockable.io/listingpage"
    
    func fetchCategories() -> Observable<[Category]?>{
        return NetworkProvider().get(urlString: urlCategroy).map({ responeJson -> [Category]? in
            if let jsonObject = responeJson as? [String: Any] {
                return Parser.parseArray(jsonArray: jsonObject["categories"])
            }
            return nil
        })
    }
    
    func fetchMediaFor(category: Category) -> Observable<[Media]?> {
        return NetworkProvider().get(urlString: category.feed!).map({ responeJson -> [Media]? in
            if let jsonObject = responeJson as? [String: Any] {
                if category.type == .Movie {
                    let movieArray : [Movie]? = Parser.parseArray(jsonArray: jsonObject["items"])
                    return movieArray
                } else {
                    let seriesArray : [Series]? = Parser.parseArray(jsonArray: jsonObject["items"])
                    return seriesArray
                }
            }
            return nil
        })
    }
    
}
