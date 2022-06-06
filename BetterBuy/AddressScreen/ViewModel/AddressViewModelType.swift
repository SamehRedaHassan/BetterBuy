//
//  AddressViewModelType.swift
//  BetterBuy
//
//  Created by nada elmasry on 6/4/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import RxSwift

protocol AddressViewModelType {
    var coordinator: Coordinator! {get}
    var isLoading: ActivityIndicator {get}
    var errorMsgSubject : PublishSubject<String?>{get}
    func goBack()
    func validateInput() -> Bool
    func addAddress(country : String , city : String , address : String)
}
