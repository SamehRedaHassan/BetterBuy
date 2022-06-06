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
    weak var coordinator: Coordinator!

    //MARK: Life cycle
    init(coordinator: Coordinator){
        self.coordinator = coordinator
        addressesResponse = addressesSubject.asObservable()
    }
    
    //MARK: Functions
    func getAddresses() {
        getApi(apiRouter: .getAllAddresses(id: "6036098154668"))
            .trackActivity(isLoading)
            .observeOn(ConcurrentDispatchQueueScheduler.init(qos: .userInitiated))
            .subscribe {[weak self] (event) in
                guard let self = self else { return }
                switch event {
                case .next(let result):
                    switch result {
                    case .success(value: let response):
                        let apiResponse = GetAddressesResponseModel(response: response)
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
        coordinator.proceedToCheckout(withSubtotal: 877.5, address: addresses[0], order: PostOrder())
    }
}
