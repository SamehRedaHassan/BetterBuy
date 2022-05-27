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
        //goToFirstPage()
//        goToSignUpPage()
        //goToFirstPage()
        goToProfilePage()
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
//        navigationController.pushViewController(splashScrViewController, animated: true)
        navigationController.pushViewController(TabBarContoller(), animated: true)
    }
    
    
    func goToCategoriesPage(){
            let categoryViewController = CategoryViewController(nibName: "CategoryView", bundle: nil)
            let categoryViewModel = CategoryViewModel.init()
            categoryViewModel.appCoordinator = self
            categoryViewController.viewModel = categoryViewModel
             navigationController.pushViewController(categoryViewController, animated: true)
    }
    
    func goToSignUpPage() {
        // Instantiate LoginViewController
         let registerViewController = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
         // Instantiate LoginViewModel
        
        let registerViewModel = RegisterViewModel()
        registerViewModel.appCoordinator = AppCoordinator(navigationController: UINavigationController.init())
         // Set the ViewModel to ViewController
         registerViewController.viewModel = registerViewModel
         // Push it.
        navigationController.pushViewController(registerViewController, animated: true)
    }
    func goToProductsPage(){
            let productsViewController = ProductsViewController(nibName: "ProductView", bundle: nil)
            let productsViewModel = ProductsViewModel.init()
            productsViewModel.appCoordinator = self
            productsViewController.viewModel = productsViewModel
             navigationController.pushViewController(productsViewController, animated: true)
    }
    
    func goToProfilePage(){
        let profileViewController = ProfileViewController(nibName: String(describing: ProfileViewController.self), bundle: nil)
            let profileViewModel = ProfileViewModel.init()
            profileViewModel.appCoordinator = self
            profileViewController.viewModel = profileViewModel
             navigationController.pushViewController(profileViewController, animated: true)
    }
    
    func goToWishListPage(){
        let wishListViewController = WishListViewController(nibName: String(describing: WishListViewController.self), bundle: nil)
            let wishListViewModel = WishListViewModel.init()
            wishListViewModel.appCoordinator = self
            wishListViewController.viewModel = wishListViewModel
             navigationController.pushViewController(wishListViewController, animated: true)
    }
    
    func goToProfileOrderListPage(){
        let orderListViewController = OrderListViewController(nibName: String(describing: OrderListViewController.self), bundle: nil)
            let orderListViewModel = OrderListViewModel.init()
            orderListViewModel.appCoordinator = self
            orderListViewController.viewModel = orderListViewModel
             navigationController.pushViewController(orderListViewController, animated: true)
    }
    
}
