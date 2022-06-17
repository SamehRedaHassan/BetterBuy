//
//  SettingViewModel.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/25/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import PopupDialog
import RxSwift

class SettingViewModel : SettingsViewModelType{

    
    //MARK: vars
    var coordinator: Coordinator
    var popup : PopupDialog?
    var cartDB : CartDBManagerType
    
    init(coordinator: Coordinator,cartDB : CartDBManagerType){
        self.coordinator = coordinator
        self.cartDB = cartDB
    }
    
    //MARK: functions
    func goToLocationScreen() {
        coordinator.goToLocationScreen()
    }

    
    func logOutUser(){
        UserDefaults.standard.set(nil, forKey: "user")
        UserDefaults.saveLoginStatus(_Val: false)
         cartDB.removeAllProductFromCart()
        coordinator.goToHomeScreen()
       
    }
    
    
    
   
}
