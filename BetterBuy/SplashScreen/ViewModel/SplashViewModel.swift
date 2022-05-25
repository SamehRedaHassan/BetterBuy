//
//  SplashViewModel.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/24/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation

final class SplashViewModel{
    
    //MARK: vars
    var appCoordinator: AppCoordinator?
    
    
//    init(appCoordinator: AppCoordinator) {
//        self.appCoordinator = appCoordinator
//    }
    
    //MARK: functions
    func goToSplashScreen() {
        appCoordinator?.goToFirstPage()
    }
}
