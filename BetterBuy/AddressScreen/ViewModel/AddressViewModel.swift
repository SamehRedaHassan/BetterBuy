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
    let isLoading: ActivityIndicator =  ActivityIndicator()
    let disposeBag = DisposeBag()
    var countrySubject : BehaviorSubject<String> = BehaviorSubject<String>(value: "")
    var citySubject : BehaviorSubject<String> = BehaviorSubject<String>(value: "")
    var addressSubject : BehaviorSubject<String> = BehaviorSubject<String>(value: "")
    var errorMsgSubject : PublishSubject<String?> = PublishSubject<String?>()
    
    weak var coordinator: Coordinator!
    
    //MARK: Life cycle
    init(coordinator: Coordinator){
        self.coordinator = coordinator
    }
    
    func goBack(){
        coordinator.popViewController()
    }
    
    func validateInput() -> Bool {
        let validCountry = try! !(countrySubject.value().isEmpty)
        guard validCountry else{
            errorMsgSubject.onNext("Please provide a country")
            return false
        }
        let validCity = try! !(citySubject.value().isEmpty)
        guard validCity else{
            errorMsgSubject.onNext("Please provide a city")
            return false
        }
        let validAddress = try! !(addressSubject.value().isEmpty)
        guard validAddress else{
            errorMsgSubject.onNext("Please provide the street name and the building number")
            return false
        }
        return true
    }
    
    
    
}
