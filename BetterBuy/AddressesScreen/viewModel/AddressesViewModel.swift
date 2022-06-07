//
//  AddressesViewModel.swift
//  BetterBuy
//
//  Created by user222682 on 6/5/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import RxSwift
class AddressesViewModel : AddressesViewModelType {

    //MARK: Properties
    let disposeBag = DisposeBag()
    let isLoading: ActivityIndicator =  ActivityIndicator()
    var addressesResponse: Observable<[Address]>
    private var addressesSubject  = BehaviorSubject<[Address]>(value:[])
    var errorMsgSubject: PublishSubject<String?> = PublishSubject()
    lazy var msg : PublishSubject<String> = PublishSubject()
    lazy var Internetmsg : PublishSubject<String> = PublishSubject()
    var isEmptyCollection : PublishSubject<Bool> = PublishSubject()
    weak var coordinator: Coordinator!
    private let subTotal : Double
    private var order : PostOrder

    //MARK: Life cycle
    init(coordinator: Coordinator , subTotal : Double , order : PostOrder){
        self.coordinator = coordinator
        addressesResponse = addressesSubject.asObservable()
        self.subTotal = subTotal
        self.order = order
        
        print(order)
        print(subTotal)
    }
    
    //MARK: Functions
    func getAddresses() {
        let userID = "\(UserDefaults.getUserObject()?.id ?? 0)"
        getApi(apiRouter: .getAllAddresses(id: userID))
            .trackActivity(isLoading)
            .observeOn(ConcurrentDispatchQueueScheduler.init(qos: .userInitiated))
            .subscribe {[weak self] (event) in
                guard let self = self else { return }
                switch event {
                case .next(let result):
                    switch result {
                    case .success(value: let response):
                        let apiResponse = GetAddressesResponseModel(response: response)
                        if((apiResponse.addresses!.isEmpty)){
                            self.isEmptyCollection.onNext(true)
                        } else {
                            self.isEmptyCollection.onNext(false)
                            
                        }
                        self.addressesSubject.onNext(apiResponse.addresses ?? [])

                     //   print(apiResponse.brands?.count)
                   
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
    func navigateToAddAddress() {
        coordinator.goToLocationScreen()
    }
    func navigateCheckout() {
        let addresses = try! addressesSubject.value()
        coordinator.proceedToCheckout(withSubtotal: subTotal, address: addresses[0], order: order)
    }
}
