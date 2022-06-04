//
//  OrderListViewModel.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/26/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation

final class OrderListViewModel : OrderlistViewModelType{
    
    //MARK: vars
    weak var coordinator: Coordinator?
    var orders : [Product]?
    var db : LocalDbType
        
    init(db : LocalDbType , coordinator: Coordinator){
        self.coordinator = coordinator
        self.db = db
    }
    
    //MARK: functions
        func getAllFavourites() {
            orders = db.getAllFavourites()
        }
    
    func deleteProductFromFavourite(product : Product){
        db.removeFavProduct(product: product)
    }
        
    
}
