//
//  SplashViewModel.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/24/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation

final class SplashViewModel : SplashViewModelType{
    
    //MARK: Properties
    weak var coordinator: Coordinator!
    
    //MARK: Life cycle
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    //MARK: Functions
    func navigateToHomeOrIntro() {
        coordinator.navigateToHomeOrIntro()
    }
}
