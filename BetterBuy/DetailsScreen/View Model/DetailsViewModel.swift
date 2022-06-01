//
//  DetailsViewModel.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/27/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation

final class DetailsViewModel{
    
    //MARK: vars
    var appCoordinator: AppCoordinator?
    var product : Product
      
    init(product : Product){
        self.product = product
    }
    
    //MARK: functions
//    func goToSignUpScreen() {
//        appCoordinator?.goToSignUpPage()
//    }
    
}
