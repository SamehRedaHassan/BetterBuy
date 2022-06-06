//
//  AddressesViewModelType.swift
//  BetterBuy
//
//  Created by user222682 on 6/5/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import RxSwift
protocol AddressesViewModelType : AnyObject {
    var coordinator: Coordinator! {get}
    var isLoading: ActivityIndicator {get}
    var addressesResponse: Observable<[Address]> {get}
    var errorMsgSubject: PublishSubject<String?> {get}
    var msg : PublishSubject<String> {get}
    var Internetmsg : PublishSubject<String> {get}
    var isEmptyCollection : PublishSubject<Bool> {get}
    func getAddresses()
    func navigateToAddAddress()
    func navigateCheckout()
}
