//
//  PostApi.swift
//  BetterBuy
//
//  Created by nada elmasry on 6/4/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import RxSwift

func postApi<T: Codable>(endPoint : PostApiRouter) -> Observable<T> {
    return Observable<T>.create { observer in
        let task = URLSession.shared.dataTask(with: endPoint.getRequest()) { (data, response, error) in
            print(error)
            print(response)
            do {
                
                let result = try JSONDecoder().decode(T.self, from: data ?? Data())
                observer.onNext( result )
            } catch let error {
                observer.onError(error)
            }
            observer.onCompleted()
        }
        task.resume()
        
        return Disposables.create {
            task.cancel()
        }
    }
}
