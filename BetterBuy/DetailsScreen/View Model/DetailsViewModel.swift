//
//  DetailsViewModel.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/27/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import RxSwift

final class DetailsViewModel : DetailsViewModelType{
     
    
    //MARK: vars
    var coordinator: Coordinator
    var product : Product?
    var images : Observable<[ProductImage]>
    var sizes : Observable<[String]>
    var db : LocalDbType
    var cartDb : CartDBManagerType
    var favourites : [Product]?
    var isInCart : Bool = false
    var isInCartObservable : BehaviorSubject<Bool>
    
    init(product : Product , db : LocalDbType , cartDb : CartDBManagerType  , coordinator: Coordinator){
        self.coordinator = coordinator
        self.product = product
        self.images = Observable.of(product.images ?? [])
        self.sizes = Observable.of(product.options?[0].values ?? [])
        self.db = db
        self.cartDb = cartDb
        isInCart = cartDb.isInCart(id: "\(product.id!)")
        isInCartObservable = BehaviorSubject(value: cartDb.isInCart(id: "\(product.id!)"))
    }
    
    //MARK: functions
    func goToSignUpScreen() {
        coordinator.goToSignUpPage()
    }
    
    func addProductToFav(product : Product){
        db.addFavProduct(product: product)
    }
    
    func getProductsFromFavourite(){
        favourites = db.getAllFavourites()
    }
    
    func addProductToCart(product : Product){
        print("sent product \(product.title!)")
        cartDb.addToCart(product: product)
        print("Products:    \( cartDb.getAllProductsInCart().count)")
        isInCartObservable.onNext(true)
    }
    
    func removeProductfromFav(product: Product) {
           db.removeFavProduct(product: product)
    }
    
    func removeProductfromCart(product: Product) {
              cartDb.removeProduct(product: product)
             isInCartObservable.onNext(false)
       }
    
    func ToggleAddAndRemoveFromCart(){
        if(isInCart){
            removeProductfromCart(product: product!)
            isInCart = false
        } else {
            addProductToCart(product: product!)
            isInCart = true
        }
    }
    
    
}
