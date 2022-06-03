//
//  API.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/30/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire
//
//let sessionManager: Session
//
//func setupSession() {
//    let configuration = URLSessionConfiguration.default
//    configuration.timeoutIntervalForRequest = 60
//    configuration.urlCache = nil
//    sessionManager = Alamofire.Session(configuration: configuration)
//}

func getApi(apiRouter :APIRouter) -> Observable<APIResult<[String:Any]>> {
    return handleDataRequest(dataRequest: requestObservable(api: apiRouter)).map({ (response) -> APIResult<[String:Any]> in
        print(response)
        if (response ?? [:]).keys.contains("Error") {
            if (response ?? [:]).keys.contains("IsInternetOff") {
                if let isInternetOff = response!["IsInternetOff"] as? Bool {
                    if isInternetOff {
                        return APIResult.internetFailure(error: APICallError(critical: false, code: InternetConnectionErrorCode.offline.rawValue, reason: response!["Error"] as! String, message: response!["Error"] as! String))
                    }
                }
            }
            return APIResult.failure(error: APICallError(critical: false, code: 1111, reason: response!["Error"] as! String, message: response!["Error"] as! String))
        }
        
        return APIResult.success(value: response ?? [:])
    })
    
}
 func handleDataRequest(dataRequest: Observable<DataRequest>) -> Observable<[String:Any]?> {
    
//    if NetworkReachabilityManager()!.isReachable == false {
//        return Observable<[String: Any]?>.create({ (observer) -> Disposable in
//            observer.on(.next(["Error":"Unable to contact the server" , "IsInternetOff":true]))
//            observer.on(.completed)
//            return Disposables.create()
//        })
//    }
    
    return Observable<[String: Any]?>.create({ (observer) -> Disposable in
        dataRequest.observeOn(MainScheduler.instance).subscribe({ (event) in
            
            switch event {
                
            case .next(let e):
                e.responseJSON(completionHandler: { (dataResponse) in
                    
                    switch dataResponse.result {
                        
                    case .success(let data):
                        
                        guard let json = data as? [String:Any] else {
                            observer.onNext(nil)
                            return
                        }
                        
                        if let status = dataResponse.response?.statusCode , status == 401 {
//                           SessionManager.cancelAllRequests()
                            observer.onNext(nil)
                            //Application.appCoordinator?.showUnAuth()
                            return
                        }
                        
                        observer.onNext(json)
                        
                    case .failure(let error):
                        let errorCode = (error as NSError).code
                        if errorCode == -1005 || errorCode == -1009 {
                            observer.onNext(["Error": NSLocalizedString("Unable to contact the server", comment: ""),
                                             "IsInternetOff":true])
                        } else {
                            observer.onNext(["Error":error.localizedDescription,
                                             "IsInternetOff":false])
                        }
                        observer.onCompleted()
                    }
                })
            case .error(let error):
                observer.onNext(["Error":error.localizedDescription])
                observer.onNext(nil)
                
            case .completed:
                observer.onCompleted()
            }
        })
    })
}
func requestObservable(api:APIRouter) -> Observable<DataRequest> {
    
    return Alamofire.SessionManager.default.rx.request( urlRequest: api)
    //sessionManager.rx.request(urlRequest: api)
}
