//
//  SearchViewModelType.swift
//  BetterBuy
//
//  Created by user222682 on 6/5/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//
import RxSwift
import Foundation
protocol SearchViewModelType : AnyObject {
    var coordinator: Coordinator! {get}
    var productsObservable : Observable<[Product]> {get}
    var isLoading: ActivityIndicator {get}
    var filterWordSubject : PublishSubject<String> {get}
    var isEmptyCollection : PublishSubject<Bool> {get}

    func getAllProducts()
    func navigateToProductDetails(atIndex : Int)

}
