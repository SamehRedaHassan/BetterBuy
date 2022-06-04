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
    var favourites : [Product]?
    
      
    init(product : Product , db : LocalDbType , coordinator: Coordinator){
        self.coordinator = coordinator
        self.product = product
        self.images = Observable.of(product.images ?? [])
        self.sizes = Observable.of(product.options?[0].values ?? [])
        self.db = db
        
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
        
    }
    
    func removeProductfromFav(product: Product) {
           db.removeFavProduct(product: product)
    }
    
}
