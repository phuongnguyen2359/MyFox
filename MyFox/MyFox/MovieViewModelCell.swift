//
//  MovieViewModelCell.swift
//  MyFox
//
//  Created by Chris on 4/10/17.
//  Copyright © 2017 RMIT. All rights reserved.
//

import Foundation
import RxSwift

class MovieViewModelCell {
    

     class func loadData(withModel: Any) -> Observable<[Media]?> {
        guard let category = withModel as? Category else {
            return Observable.empty()
        }
        return CategoryProvider().fetchMediaFor(category: category)
            
    }

}
