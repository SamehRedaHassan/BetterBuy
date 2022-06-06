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
       
//        let validCountry = try! (countrySubject.value().count > 0)
//        guard validCountry else{
//            errorMsgSubject.onNext("Please provide a country")
//            return false
//        }
//        let validCity = try! (citySubject.value().count > 0)
//        guard validCity else{
//            errorMsgSubject.onNext("Please provide a city")
//            return false
//        }
//        let validAddress = try! (addressSubject.value().count > 0)
//        guard validAddress else{
//            errorMsgSubject.onNext("Please provide the street name and the building number")
//            return false
//        }
//

        return true
    }
    func addAddress(country: String, city: String, address: String){
        let address = Address(id: 0, customerID: 6036098154668, address1: address, city: city, country: country)
       let addressObject  = AddAddressPostModel(address: address)
        let result : Observable<GetAddressesResponseModel> = postApi(endPoint: .addAddress(address: addressObject))
            result.subscribe(onNext: { [weak self] (result) in
                guard let self = self else {return}
                
                //MARK: The returned type is not of type customer (No id)
                //print (result.customer?.firstName!)
                print(result.addresses)
                

                
           //     self.successMsgSubject.onNext("Registered Successfully.")
            }, onError: { (error) in
                self.errorMsgSubject.onNext("An error occured please try again.")
            }, onCompleted: {
                print("completed")
                }).disposed(by: disposeBag)
    }
    
    
}
