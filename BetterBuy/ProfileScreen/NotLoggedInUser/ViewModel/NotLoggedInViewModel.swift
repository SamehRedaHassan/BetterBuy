//
//  NotLoggedInViewModel.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/27/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation

final class NotLoggedInViewModel{
    
    //MARK: vars
       var appCoordinator: AppCoordinator?
           
       
       //MARK: functions
       func goToRegisterScreen() {
        appCoordinator?.goToSignUpPage()
       }
       
       func goToLoginScreen() {
        appCoordinator?.goToLoginPage()
       }
    
}
