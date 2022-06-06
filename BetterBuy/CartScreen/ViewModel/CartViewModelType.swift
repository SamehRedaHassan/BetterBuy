//
//  CartViewModelType.swift
//  BetterBuy
//
//  Created by user222682 on 6/4/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import RxSwift
protocol CartViewModelType : AnyObject{
    var coordinator: Coordinator! {get}
    func goBack()
    func proceedToCheckout()
    func retieveProductsInCart()
    func incrementProductCount(productId : String)-> Int
    func decrementProductCount(productId : String)-> Int
    var cartObservabel : Observable<[Product]> {get}
    var totalPriceObservabel : Observable<String>{get}
     var isEmptyCollection : PublishSubject<Bool> {get}
    func updateTotalPrice()
    func removeProductCount(product : Product)
    func noOrdersAvailable() -> Bool
    
}
