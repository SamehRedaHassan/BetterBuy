//
//  OrderListViewModel.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/26/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation

final class OrderListViewModel{
    
    //MARK: vars
    var appCoordinator: AppCoordinator?
    var orders : [Order]
        
    init(orders : [Order]){
        self.orders = orders
    }
    
    //MARK: functions
    //    func goToSignUpScreen() {
    //        appCoordinator?.goToSignUpPage()
    //    }
        
    
}
