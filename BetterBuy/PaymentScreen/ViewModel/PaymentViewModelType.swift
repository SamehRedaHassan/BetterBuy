//
//  PaymentViewModelType.swift
//  BetterBuy
//
//  Created by user222682 on 6/4/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import RxSwift
protocol PaymentViewModelType : AnyObject{
    var coordinator: Coordinator! {get}
    var isLoading: ActivityIndicator {get}
    var msg : BehaviorSubject<String>{get set}
    var Internetmsg : BehaviorSubject<String>{get set}
    var promoCodeSubject : BehaviorSubject<String> {get set}
    var isValidPromoCode : BehaviorSubject<Bool> {get set}
    var bagTotal : BehaviorSubject<Double> {get set}
    var bagSubTotal : BehaviorSubject<Double> {get set}
    var deliveryAdddress : Address {get}
    func getAllCoupons()
    func placeOrder()
    func checkPromoCode()
    
}
