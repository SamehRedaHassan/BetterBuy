//
//  HomeViewModel.swift
//  BetterBuy
//
//  Created by user222682 on 5/31/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//
import RxSwift
import Foundation
//import NVActivityIndicatorView
class HomeViewModel : HomeViewModelType{
    //let isLoading: ActivityIndicator =  ActivityIndicator()
    let disposeBag = DisposeBag()
    var brandsObservable : Observable<[BrandModel]>
   lazy private var msg = BehaviorSubject<String>(value: "")
   lazy private var Internetmsg = BehaviorSubject<String>(value: "")
    private var brandsResponse   = BehaviorSubject<[BrandModel]>(value:[])
    init(){
        brandsObservable = brandsResponse.asObservable()
    }
    
    func getCustomers() {
        getApi(apiRouter: .getAllBrands)
      //      .trackActivity(isLoading)
            .observeOn(ConcurrentDispatchQueueScheduler.init(qos: .userInitiated))
            .subscribe {[weak self] (event) in
                guard let self = self else { return }
                switch event {
                case .next(let result):
                    switch result {
                    case .success(value: let response):
                        let apiResponse = GetBrandsResponseModel(response: response)
                        self.brandsResponse.onNext(apiResponse.brands ?? [])
                        print(apiResponse.brands?.count)
                   
                    case .internetFailure(let error):
                        self.Internetmsg.onNext(error.message)

                    case .failure(let error):
                        self.msg.onNext(error.message)
                    }
                default:
                    break
                }
            }.disposed(by: disposeBag)
    }

}
