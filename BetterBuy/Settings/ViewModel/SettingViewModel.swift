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
    
    
    init(coordinator: Coordinator){
        self.coordinator = coordinator
    }
    
    //MARK: functions
    func goToLocationScreen() {
        coordinator.goToLocationScreen()
    }

    
    func logOutUser(){
        UserDefaults.standard.set(nil, forKey: "user")
        UserDefaults.saveLoginStatus(_Val: false)
        coordinator.goToHomeScreen()
    }
    
    
    
   
}
