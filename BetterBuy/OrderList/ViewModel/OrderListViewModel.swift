//
//  OrderListViewModel.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/26/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import RxSwift

final class OrderListViewModel : OrderlistViewModelType{
    
    //MARK: vars
    weak var coordinator: Coordinator?
    var orders : [Product]?
    var db : LocalDbType
   // var isEmptyCollection : PublishSubject<Bool> = PublishSubject()
     var isEmptyCollection = BehaviorSubject<Bool>(value: true)
        
    init(db : LocalDbType , coordinator: Coordinator){
        self.coordinator = coordinator
        self.db = db
    }
    
    //MARK: functions
        func getAllFavourites() {
            orders = db.getAllFavourites()
            print(orders?.count)
            self.isEmptyCollection.onNext(orders?.isEmpty ?? true)
    }
    
    func deleteProductFromFavourite(product : Product){
        db.removeFavProduct(product: product)
    }
    func isFavouriteEmpty() -> Bool {
        return try! isEmptyCollection.value()
    }
        
    
}
