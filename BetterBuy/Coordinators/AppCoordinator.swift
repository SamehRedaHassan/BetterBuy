//
//  AppCoordinator.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/24/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import UIKit


class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    
    //MARK: init
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    //MARK: functions
    func start() {
         // The first time this coordinator started, is to launch login page.
        goToFirstPage()
    }
    
    func goToFirstPage(){
         // Instantiate LoginViewController
         let splashScrViewController = SplashViewController(nibName: "SplashScreen", bundle: nil)
         // Instantiate LoginViewModel
        
        let splashScreenViewModel = SplashViewModel()
        splashScreenViewModel.appCoordinator = AppCoordinator(navigationController: UINavigationController.init())
         // Set the ViewModel to ViewController
         splashScrViewController.viewModel = splashScreenViewModel
         // Push it.
        navigationController.pushViewController(splashScrViewController, animated: true)
    }
    
    
    func goToSecPage(){
//        let secScreenViewController = secViewController(nibName: "secViewController", bundle: nil)
//        let secScreenViewModel = secViewModel.init()
//        secScreenViewModel.appCoordinator = self
//        secScreenViewController.viewModel = secScreenViewModel
//         navigationController.pushViewController(secScreenViewController, animated: true)
    }
}
