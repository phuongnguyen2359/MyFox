//
//  HomeViewModel.swift
//  MyFox
//
//  Created by Chris on 4/7/17.
//  Copyright © 2017 RMIT. All rights reserved.
//

import Foundation
import RxSwift

class HomeViewModel {
    
    var disposableBag = DisposeBag()
    var categoriesObservable : Variable<[Category]> = Variable([])
    var categories: [Category] {
        get {
            return categoriesObservable.value
        }
        set {
            categoriesObservable.value = newValue
        }
    }
    
    func fetchHomePageContent() {
        CategoryProvider().fetchCategories().subscribe(onNext: { categories in
            if let categories = categories {
                self.categories = categories
            }
        }).addDisposableTo(disposableBag)
    }
}
