//
//  WishListViewModel.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/26/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import RxSwift

final class WishListViewModel : WishListViewModelType{
    
    
    //MARK: vars
    weak  var coordinator: Coordinator!
    var orders : [Order]
    var  db : LocalDbType
   
    
    init(orders:[Order] , db : LocalDbType , coordinator: Coordinator) {
        self.coordinator = coordinator
        self.orders = orders
        self.db = db
    }
    
    
    //MARK: functions
//    func viewAllFavourites() {
//        appCoordinator?.goToSignUpPage()
//    }
    
}
