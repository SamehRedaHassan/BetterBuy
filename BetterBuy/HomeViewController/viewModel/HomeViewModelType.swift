//
//  HomeViewModelType.swift
//  BetterBuy
//
//  Created by user222682 on 5/31/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import RxSwift
protocol HomeViewModelType : AnyObject{
    var coordinator: Coordinator! {get}
    var brandsObservable : Observable<[BrandModel]> {get}
    var ads : Observable<[String]> {get}
    var isLoading: ActivityIndicator {get}
    func getCustomers()
    func navigateToProducts(withBrandAtIndex : IndexPath)
}
