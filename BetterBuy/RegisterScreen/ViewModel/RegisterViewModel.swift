//
//  SignInViewModel.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/25/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation

class RegisterViewModel : RegisterViewModelType {
    
    //MARK: vars
    var coordinator: Coordinator
    
    init(coordinator: Coordinator){
        self.coordinator = coordinator
    }
    
    //MARK: functions
    func goToLoginUpScreen() {
        coordinator.goToLoginPage()
    }
    
}
