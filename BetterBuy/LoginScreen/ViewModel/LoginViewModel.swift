//
//  LoginViewModel.swift
//  BetterBuy
//
//  Created by Mohamed Adel on 5/29/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
final class LoginViewModel : LoginViewModelType{
  
    //MARK: Properties
    weak var coordinator: Coordinator!
    
    //MARK: Life cycle
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    //MARK: Functions
    func navigateToSignup(){
        coordinator.goToSignUpPage()
    }
    
    func goBack() {
        coordinator.popViewController()
    }
}
