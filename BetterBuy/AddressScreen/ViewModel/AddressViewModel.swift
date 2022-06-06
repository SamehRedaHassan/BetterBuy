//
//  AddressViewModel.swift
//  BetterBuy
//
//  Created by nada elmasry on 6/4/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import RxSwift

final class AddressViewModel : AddressViewModelType{
  
    
    
    //MARK: Properties
    let isLoading: ActivityIndicator =  ActivityIndicator()
    let disposeBag = DisposeBag()
    var errorMsgSubject : PublishSubject<String?> = PublishSubject<String?>()
    var successMsgSubject : PublishSubject<String?> = PublishSubject<String?>()
    var address :  PublishSubject<String> = PublishSubject()
    weak var coordinator: Coordinator!
    
    //MARK: Life cycle
    init(coordinator: Coordinator){
        self.coordinator = coordinator
     //   self.address = addressSubject.asObservable()
    }
    
    //MARK: Functions
    func goBack(){
        coordinator.popViewController()
    }
    
    func validateInput() -> Bool {
        return true
    }
    func addAddress(country: String, city: String, address: String){
        let customerId = UserDefaults.getUserObject()?.id
        let address = Address(id: 0, customerID: customerId, address1: address, city: city, country: country)
       let addressObject  = AddAddressPostModel(address: address)
        let result : Observable<AddressResponse> = postApi(endPoint: .addAddress(address: addressObject))
            result.subscribe(onNext: { [weak self] (result) in
                guard let self = self else {return}
                self.successMsgSubject.onNext("Successfully added")
            }, onError: { (error) in
                self.errorMsgSubject.onNext("An error occured please try again.")
            }, onCompleted: {
                print("completed")
                }).disposed(by: disposeBag)
    }
    
}
