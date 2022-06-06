//
//  DetailsViewModelType.swift
//  BetterBuy
//
//  Created by nada elmasry on 6/3/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import RxSwift

protocol DetailsViewModelType : AnyObject {
    var coordinator: Coordinator {get}
    var isInCart : Bool {get set}
    func addProductToFav(product : Product)
    func removeProductfromFav(product : Product)
    func addProductToCart(product : Product)
    var product : Product? { get set}
    var images : Observable<[ProductImage]> { get }
    var sizes : Observable<[String]> { get }
    var favourites : [Product]? { get }
    var isInCartObservable : BehaviorSubject<Bool> {get}
    func goToSignUpScreen()
    func getProductsFromFavourite()
    func removeProductfromCart(product: Product)
    func ToggleAddAndRemoveFromCart()
}
