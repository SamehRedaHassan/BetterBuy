//
//  WishListViewModel.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/26/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation

final class WishListViewModel{
    
    //MARK: vars
    var appCoordinator: AppCoordinator?
    var orders : [Order]
    var  db : LocalDbType
    
    init(orders:[Order] , db : LocalDbType) {
        self.orders = orders
        self.db = db
    }
    
    //MARK: functions
//    func viewAllFavourites() {
//        appCoordinator?.goToSignUpPage()
//    }
    
}
