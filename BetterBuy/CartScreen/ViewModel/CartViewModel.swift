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
    lazy var isEmptyCollection : PublishSubject<Bool> = PublishSubject()
    var products: [Product] = []
    
    var cartObservabel : Observable<[Product]>
    private var cartSubject : BehaviorSubject<[Product]> = BehaviorSubject<[Product]>(value: [])
    
    var totalPriceObservabel : Observable<String>
    private var totalPriceSubject : BehaviorSubject<String> = BehaviorSubject<String>(value: "")
    
    
    //MARK: Life cycle
    init(coordinator: Coordinator,cartCoreData:CartDBManagerType) {
        self.coordinator = coordinator
        self.cartCoreData = cartCoreData
        cartObservabel = cartSubject.asObservable()
        totalPriceObservabel = totalPriceSubject.asObserver()
    }
    
    //MARK: Functions
    
    func removeAllProductsFromCart() {
        cartCoreData.removeAllProductFromCart()
    }
    
    
    
    func goBack() {
        coordinator.popViewController()
    }
    
    func proceedToCheckout() {
        let value = try! totalPriceSubject.value()
        let doubleValue = value.replacingOccurrences(of: "EGP ", with: "")
        let doubleValuee = doubleValue.replacingOccurrences(of: "$", with: "")

        print(value)
        guard let orders = createPostOrder() else {return}
        coordinator.navigateToAddressesScreen(withSubtotal: Double(doubleValuee) ?? 0.0, order: orders)
    }
    
    func createPostOrder() -> PostOrder? {
        guard let items = try? cartSubject.value() else {return nil}
        var itemsList : [OrderItem] = []
        items.forEach { (product) in
            let order = OrderItem(id: 0, giftCard: nil, productExists: nil, productID: product.id, quantity: product.count, title: product.title, totalDiscount: nil, variantID: nil , price: String( product.variants?[0].price ?? "70.0"))
            itemsList.append(order)
            
        }
        let order = Order(customer: UserDefaults.getUserObject()!, orderItems: itemsList)
        print(PostOrder(order: order))
        return PostOrder(order: order)
    }
    
    //MARK:- Dealing with coredate
    func retieveProductsInCart(){
        products = cartCoreData.getAllProductsInCart()
        cartSubject.onNext(products)
        isEmptyCollection.onNext(products.isEmpty)
        updateTotalPrice()
        
    }
    func incrementProductCount(productId : String)-> Int {
        return cartCoreData.plusCountByOne(id: productId)
    }
    func decrementProductCount(productId : String)-> Int {
        let count = cartCoreData.minusCountByOne(id: productId)
        print(count)
        if(count == 0){
            products = cartCoreData.getAllProductsInCart()
            if(products.count - 1 == 0){
                isEmptyCollection.onNext(true)
            }
            print(products.count)
        }
        return count
    }
    func removeProductCount(product : Product){
        cartCoreData.removeProduct(product:product)
        cartSubject.onNext(cartCoreData.getAllProductsInCart())
        updateTotalPrice()
    }
    func updateTotalPrice(){
        totalPriceSubject.onNext(returnPrice(price: Double(cartCoreData.calcuTotalPrice() ?? "0.0") ?? 0.0))
        
    }
    
    func noOrdersAvailable() -> Bool{
        return try! cartSubject.value().isEmpty
    }
    
    
}
