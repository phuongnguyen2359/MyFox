//
//  NetworkProvider.swift
//  MyFox
//
//  Created by Chris on 4/7/17.
//  Copyright © 2017 RMIT. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

class NetworkProvider {
    
    func get(urlString: String) -> Observable<Any> {
        return Observable.create({ (observer) -> Disposable in
            let request = Alamofire.request(urlString, method: .get).validate()
            request.responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let jsonResponse):
                    observer.onNext(jsonResponse)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                    observer.onCompleted()
                }
            })
            return Disposables.create {
                request.cancel()
            }
        })
    }
}


