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
       var coordinator: Coordinator
           
    init(coordinator: Coordinator){
        self.coordinator = coordinator
    }
       
       //MARK: functions
       func goToRegisterScreen() {
        coordinator.goToSignUpPage()
       }
       
       func goToLoginScreen() {
        coordinator.goToLoginPage()
       }
    
}
