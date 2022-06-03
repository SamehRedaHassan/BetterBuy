//
//  PostApi.swift
//  BetterBuy
//
//  Created by user222682 on 6/1/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import RxSwift
import Foundation

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


//MARK: - The request function to get results in an Observable
enum EndPoint:String{
    case register = "2022-04/customers.json"
}
enum HTTPMethod : String{
    case get
    case post
}
 func postRequest<T: Decodable>(fromEndpoint: EndPoint, httpBody: Data?, httpMethod : HTTPMethod ) -> Observable<T> {
    
    return Observable<T>.create { observer in
        guard let url = URL(string: "\(BASE_URL)\(fromEndpoint.rawValue)") else {
            observer.onError(NSError(domain: "", code: 500, userInfo: nil))
            return Disposables.create {}
        }
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.httpShouldHandleCookies = false
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if let httpBody = httpBody {
            request.httpBody = httpBody
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error{
                print(error)
                observer.onError(error)
            }else{
                if let data = data {
                    do{
                        let jsonDecoder = JSONDecoder()
                        let result = try jsonDecoder.decode(T.self, from: data)
                        observer.onNext( result )
                    }catch{
                        observer.onError(error)
                        
                    }
                }
            }
        }
        task.resume()
        
        return Disposables.create {
            task.cancel()
        }
    }
}
