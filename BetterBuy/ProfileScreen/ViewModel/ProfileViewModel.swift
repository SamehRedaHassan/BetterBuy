//
//  ProfileViewModel.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/25/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import RxSwift

final class ProfileViewModel : ProfileViewModelType{
    var customer: Customer?
    var orders: [Order]?
    var didFetchData: (() -> ())?
    
    
    //MARK: properties
    //let isLoading: ActivityIndicator =  ActivityIndicator()
    var appCoordinator: AppCoordinator?
    let disposeBag = DisposeBag()
    var profileObservable: Observable<Customer?>
    lazy private var msg = BehaviorSubject<String>(value: "")
    lazy private var Internetmsg = BehaviorSubject<String>(value: "")
    private var profileResponse   = BehaviorSubject<Customer?>(value:nil)
    var orderObservable: Observable<Orders?>
    private var orderResponse   = BehaviorSubject<Orders?>(value:nil)


    
    //MARK: init
    init(){
        profileObservable = profileResponse.asObservable()
        orderObservable = orderResponse.asObservable()
    }
    
    
    //MARK: Methods
    func getProfileDetails() {
        
        getApi(apiRouter: .getCustomerById(id: getUserId()))
        //      .trackActivity(isLoading)
              .observeOn(ConcurrentDispatchQueueScheduler.init(qos: .userInitiated))
              .subscribe {[weak self] (event) in
                  guard let self = self else { return }
                  switch event {
                  case .next(let result):
                      switch result {
                      case .success(value: let response):
                        print(response)
                          let apiResponse = GetProfileModelResponse(response: response)
                        self.customer = apiResponse.customer
                        self.didFetchData?()
                      //  self.profileResponse.onNext(apiResponse.customer)
                          print(apiResponse)
                     
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
    
    func getCustomerOrders() {
        
        getApi(apiRouter: .getCustomerOrders(id: getUserId()))
        //      .trackActivity(isLoading)
              .observeOn(ConcurrentDispatchQueueScheduler.init(qos: .userInitiated))
              .subscribe {[weak self] (event) in
                  guard let self = self else { return }
                  switch event {
                  case .next(let result):
                      switch result {
                      case .success(value: let response):
                        print(response)
                          let apiResponse = Orders(response: response)
                        self.orders = apiResponse.orders
                        self.didFetchData?()
                      //  self.profileResponse.onNext(apiResponse.customer)
                          print(apiResponse)
                     
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
    
    
    func goToWishListScreen(orders: [Order]) {
        appCoordinator?.goToWishListPage(orders: orders)
    }
    
    func goToOrderListScreen(orders : [Order]) {
        appCoordinator?.goToProfileOrderListPage(orders : orders)
    }
    
    func getUserId() -> String {
        return "6236240937195"
    }
    
}
