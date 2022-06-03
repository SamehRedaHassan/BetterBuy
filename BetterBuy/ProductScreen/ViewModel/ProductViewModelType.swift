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
    var productsObservable : Observable<[Product]> {get}
    func goToProductDetailsScreen(product : Int) 
    func getProducts()
}
