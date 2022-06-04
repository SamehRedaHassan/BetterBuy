//
//  DetailsViewModelType.swift
//  BetterBuy
//
//  Created by nada elmasry on 6/3/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import RxSwift

protocol DetailsViewModelType {
    func goToSignUpScreen()
    func addProductToFav(product : Product)
    func removeProductfromFav(product : Product)
    func getProductsFromFavourite()
    func addProductToCart(product : Product)
    var product : Product? { get set}
    var images : Observable<[ProductImage]> { get }
    var sizes : Observable<[String]> { get }
    var favourites : [Product]? { get }
}
