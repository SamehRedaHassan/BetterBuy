//
//  ProfileViewModel.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/25/22.
//

import Foundation
import RxSwift

final class ProfileViewModel : ProfileViewModelType{
    var favourites: [Product]?
    var customer: Customer?
    var orders: [Order]?
    var didFetchData: (() -> ())?
    
    
    //MARK: properties
    //let isLoading: ActivityIndicator =  ActivityIndicator()
    var coordinator: Coordinator
    let disposeBag = DisposeBag()
    var profileObservable: Observable<Customer?>
    lazy private var msg = BehaviorSubject<String>(value: "")
    lazy private var Internetmsg = BehaviorSubject<String>(value: "")
    private var profileResponse   = BehaviorSubject<Customer?>(value:nil)
    var orderObservable: Observable<Orders?>
    private var orderResponse   = BehaviorSubject<Orders?>(value:nil)
    var db : LocalDbType


    
    //MARK: init
    init(db : LocalDbType , coordinator: Coordinator){
        self.coordinator = coordinator
        profileObservable = profileResponse.asObservable()
        orderObservable = orderResponse.asObservable()
        self.db = db
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
    
    
    func goToWishListScreen() {
        coordinator.goToWishListPage(orders: orders ?? [])
    }
    
    func goToOrderListScreen() {
        coordinator.goToProfileOrderListPage()
    }
    
    //MARK: Change To user id from user defaults
    func getUserId() -> String {
        return "6236240937195"
    }
    
    func getAllFavourites(){
        favourites = db.getAllFavourites()
    }
    
    func deleteProductFromFav(product : Product){
        db.removeFavProduct(product: product)
    }
    
}
