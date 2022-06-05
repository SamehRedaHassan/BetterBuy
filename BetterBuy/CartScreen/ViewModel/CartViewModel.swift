//
//  CartViewModel.swift
//  BetterBuy
//
//  Created by Mohamed Adel on 5/29/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import RxSwift
class CartViewModel : CartViewModelType{

    //MARK: Properties
    weak var coordinator: Coordinator!
    var cartCoreData : CartDBManagerType!
    var productsInCart : [Product]?
    
    var cartObservabel : Observable<[Product]>
    private var cartSubject : PublishSubject<[Product]> = PublishSubject<[Product]>()
    //MARK: Life cycle
    init(coordinator: Coordinator,cartCoreData:CartDBManagerType) {
        self.coordinator = coordinator
        self.cartCoreData = cartCoreData
        cartObservabel = cartSubject.asObservable()
    }
    
    //MARK: Functions
    func goBack() {
        coordinator.popViewController()
    }
    
    func proceedToCheckout() {
        coordinator.proceedToCheckout(withSubtotal: 875.0)
    }
    //MARK:- Dealing with coredate
    func retieveProductsInCart(){
        cartSubject.onNext(cartCoreData.getAllProductsInCart())
        
    }
    func incrementProductCount(productId : String)-> Int {
        return cartCoreData.plusCountByOne(id: productId)
    }
    func decrementProductCount(productId : String)-> Int {
        return cartCoreData.minusCountByOne(id: productId)
    }
    
    
}
