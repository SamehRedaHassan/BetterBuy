//
//  ProfileViewModelType.swift
//  BetterBuy
//
//  Created by nada elmasry on 6/1/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import RxSwift
protocol ProfileViewModelType{
    //var profileObservable : Observable<Customer?> {get}
    var customer : Customer? {get}
    var orders: [Order]? {get}
    var didFetchData: (() -> ())? {get set}
    func getProfileDetails()
    func goToOrderListScreen(orders : [Order])
    func goToWishListScreen(orders : [Order])
    func getCustomerOrders()
}
