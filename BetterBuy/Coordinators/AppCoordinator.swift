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
    
    
    func goToCategoriesPage(){
            let categoryViewController = CategoryViewController(nibName: "CategoryView", bundle: nil)
            let categoryViewModel = CategoryViewModel.init()
            categoryViewModel.appCoordinator = self
            categoryViewController.viewModel = categoryViewModel
             navigationController.pushViewController(categoryViewController, animated: true)
    }
}
