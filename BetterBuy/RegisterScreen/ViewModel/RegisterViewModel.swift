//
//  SignInViewModel.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/25/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation

class RegisterViewModel{
    
    //MARK: vars
    var appCoordinator: AppCoordinator?
        
    
    //MARK: functions
    func goToLoginUpScreen() {
        appCoordinator?.goToLoginPage()
    }
    
}
