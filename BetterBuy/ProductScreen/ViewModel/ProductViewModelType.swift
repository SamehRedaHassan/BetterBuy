//
//  ProductViewModelType.swift
//  BetterBuy
//
//  Created by Mohamed Adel on 6/1/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import RxSwift

protocol ProductViewModelType {
    var coordinator:Coordinator! {get}
    var productsObservable : Observable<[Product]> {get}
    var favouriteCoreData : LocalDbType {get}
    func navigateToProducts(index:Int)
    func getProducts()
    func addProductToFav(index:Int)
    func removeProductFromFav(index:Int)
}
