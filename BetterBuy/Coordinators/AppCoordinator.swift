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
        navigationController.isNavigationBarHidden = true
    }


    //MARK: functions
    func start() {
        // The first time this coordinator started, is to launch login page.
        //goToFirstPage()
        //goToSignUpPage()
        //goToSettingsPage()
        //goToProfilePage()
        goToProductsPage()
        //goToLoginPage()
        //goToNotLoogedInProfilePage()
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
        navigationController.viewControllers = [TabBarContoller()]

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
        registerViewModel.appCoordinator=self
         // Set the ViewModel to ViewController
         registerViewController.viewModel = registerViewModel
         // Push it.
        navigationController.pushViewController(registerViewController, animated: true)
    }
    func goToProductsPage(){
//            let productsViewController = ProductsViewController(nibName: "ProductView", bundle: nil)
        
            let productsViewModel = ProductsViewModel.init()
            let productsViewController = ProductsViewController(productViewModel: productsViewModel)
            productsViewModel.appCoordinator = self
             navigationController.pushViewController(productsViewController, animated: true)
    }



    func goToProfilePage(){
        let profileViewModel = ProfileViewModel()
        let profileViewController = ProfileViewController(profileViewModel: profileViewModel)
            
            profileViewModel.appCoordinator = self
            profileViewController.viewModel = profileViewModel
             navigationController.pushViewController(profileViewController, animated: true)
    }

    func goToWishListPage(orders : [Order]){
        let wishListViewController = WishListViewController(nibName: String(describing: WishListViewController.self), bundle: nil)
        let wishListViewModel = WishListViewModel.init(orders: orders)
            wishListViewModel.appCoordinator = self
            wishListViewController.viewModel = wishListViewModel
             navigationController.pushViewController(wishListViewController, animated: true)
    }

    func goToProfileOrderListPage(orders : [Order]){
        let orderListViewController = OrderListViewController(nibName: String(describing: OrderListViewController.self), bundle: nil)
            let orderListViewModel = OrderListViewModel.init(orders: orders)
            orderListViewModel.appCoordinator = self
            orderListViewController.viewModel = orderListViewModel
             navigationController.pushViewController(orderListViewController, animated: true)
    }


    func goToNotLoogedInProfilePage(){
        let notLoggedInViewController = NotLoggedInProfileViewController(nibName: String(describing: NotLoggedInProfileViewController.self), bundle: nil)
            let notLoggedInViewModel = NotLoggedInViewModel.init()
            notLoggedInViewModel.appCoordinator = self
            notLoggedInViewController.viewModel = notLoggedInViewModel
             navigationController.pushViewController(notLoggedInViewController, animated: true)
    }

   


    func goToProductDetailsPage(product: Product){
        let goToProductDetailsViewController = DetailsViewController(nibName: String(describing: DetailsViewController.self), bundle: nil)
            let goToProductDetailsViewModel = DetailsViewModel.init(product: product)
            goToProductDetailsViewModel.appCoordinator = self
            goToProductDetailsViewController.viewModel = goToProductDetailsViewModel
             navigationController.pushViewController(goToProductDetailsViewController, animated: true)
    }



    func goToOnboardingScreen(){
            let onboardingViewController = SlideContainerViewController()
          //  let productsViewModel = ProductsViewModel.init()
          //  productsViewModel.appCoordinator = self
           // productsViewController.viewModel = productsViewModel
        onboardingViewController.coordinator = self
             navigationController.pushViewController(onboardingViewController, animated: true)
    }


    func goToLoginPage(){
            let loginViewController = LoginViewController(nibName: "LoginView", bundle: nil)
            let loginViewModel = LoginViewModel.init()
            loginViewModel.appCoordinator = self
            loginViewController.viewModel = loginViewModel
            navigationController.pushViewController(loginViewController, animated: true)
    }
    func goToCartPage(){
            let cartViewController = CartViewController(nibName: "CartView", bundle: nil)
            let cartViewModel = CartViewModel.init()
            cartViewModel.appCoordinator = self
            cartViewController.viewModel = cartViewModel
            navigationController.pushViewController(cartViewController, animated: true)
    }
    
    func goToSettingsPage(){
        let settingsViewController = SettingsViewController(nibName: String(describing: SettingsViewController.self), bundle: nil)
            let settingsViewModel = SettingViewModel.init()
            settingsViewModel.appCoordinator = self
            settingsViewController.viewModel = settingsViewModel
            navigationController.pushViewController(settingsViewController, animated: true)
    }

}
