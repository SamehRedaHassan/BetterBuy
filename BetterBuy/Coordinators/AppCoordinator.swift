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
        //goToFirstPage()
        //goToSignUpPage()
        //goToSettingsPage()
        //goToProfilePage()
        // goToProductsPage(category: " men")
        goToSplashScreen()
        //goToNotLoogedInProfilePage()
    }
    
    func goToSplashScreen(){
        let splashScreenViewModel = SplashViewModel(coordinator: self)
        let splashScrViewController = SplashViewController(splashViewModel: splashScreenViewModel)
        navigationController.viewControllers = [splashScrViewController]
    }
    
    func navigateToHomeOrIntro() {
        if(UserDefaults.isFirstLaunch()){
            goToOnboardingScreen()
        }else{
            goToHomeScreen()
        }
    }
    
    func goToOnboardingScreen(){
        let onBoardingViewModel = SlideContainerViewModel(coordinator: self)
        let onboardingViewController = SlideContainerViewController()
        onboardingViewController.injectViewModel(viewModel:onBoardingViewModel)
        navigationController.pushViewController(onboardingViewController, animated: true)
    }
    
    func goToHomeScreen(){
        let tabbarController = TabBarContoller(coordinator: self)
     //   tabbarController.injectCoordinator(coordinator: self)
        self.navigationController.viewControllers = [tabbarController]
    }
    
    
    func goToCategoriesPage(){
        let categoryViewModel = CategoryViewModel.init(coordinator: self)
        let categoryViewController = CategoryViewController(categoryViewModel: categoryViewModel)
        navigationController.pushViewController(categoryViewController, animated: true)
    }
    
    func goToSignUpPage() {
        let registerViewModel = RegisterViewModel(coordinator: self)
        let registerViewController = RegisterViewController(viewModel: registerViewModel)
        navigationController.pushViewController(registerViewController, animated: true)
    }
    func goToProductsPage(category:String,brand:String){
        let productsViewModel = ProductsViewModel.init(category: category, brand: brand, favouriteCoreData: DbManager.getInstance(appDelegate: UIApplication.shared.delegate as! AppDelegate), coordinator: self)
        let productsViewController = ProductsViewController(productViewModel: productsViewModel)
        navigationController.pushViewController(productsViewController, animated: true)
    }
    
    
    func goToProfilePage(){
        let profileViewModel = ProfileViewModel(db: DbManager.getInstance(appDelegate: UIApplication.shared.delegate as! AppDelegate), coordinator: self)
        let profileViewController = ProfileViewController(profileViewModel: profileViewModel)
        navigationController.pushViewController(profileViewController, animated: true)
    }
    
    func goToWishListPage(orders : [Order]){
        let wishListViewModel = WishListViewModel(  orders: orders, db: DbManager.getInstance(appDelegate: UIApplication.shared.delegate as! AppDelegate), coordinator: self)
        let wishListViewController = WishListViewController(wishListViewModel: wishListViewModel)
        navigationController.pushViewController(wishListViewController, animated: true)
    }
    
    func goToProfileOrderListPage(){
        let orderListViewController = OrderListViewController(nibName: String(describing: OrderListViewController.self), bundle: nil)
        let orderListViewModel = OrderListViewModel.init(db: DbManager.getInstance(appDelegate: UIApplication.shared.delegate as! AppDelegate), coordinator: self)
        orderListViewController.viewModel = orderListViewModel
        navigationController.pushViewController(orderListViewController, animated: true)
    }
    
    
    func goToNotLoogedInProfilePage(){
        let notLoggedInViewModel = NotLoggedInViewModel.init(coordinator: self)

        let notLoggedInViewController = NotLoggedInProfileViewController(notLoggedInViewModel: notLoggedInViewModel)
        navigationController.pushViewController(notLoggedInViewController, animated: true)
    }
    

    func goToProductDetailsPage(product: Product){
       let productDetailsViewModel = DetailsViewModel.init(product: product, db: DbManager.getInstance(appDelegate: UIApplication.shared.delegate as! AppDelegate), coordinator: self)
        let productDetailsViewController = DetailsViewController(viewModel: productDetailsViewModel as! DetailsViewModelType)
        navigationController.pushViewController(productDetailsViewController, animated: true)
    }
    
    func goToLoginPage(){
        let loginViewController = LoginViewController(nibName: "LoginView", bundle: nil)
        let loginViewModel = LoginViewModel.init()
        loginViewModel.appCoordinator = self
        loginViewController.viewModel = loginViewModel
        navigationController.pushViewController(loginViewController, animated: true)
    }
    func goToCartPage(){
        let cartViewModel = CartViewModel(coordinator: self)
        let cartViewController = CartViewController(cartViewModel: cartViewModel)
        navigationController.pushViewController(cartViewController, animated: true)
    }
    
    func goToSettingsPage(){
        let settingsViewController = SettingsViewController(nibName: String(describing: SettingsViewController.self), bundle: nil)
        let settingsViewModel = SettingViewModel.init()
        settingsViewModel.appCoordinator = self
        settingsViewController.viewModel = settingsViewModel
        navigationController.pushViewController(settingsViewController, animated: true)
    }
    
    func popViewController(){
        self.navigationController.popViewController(animated: true)
    }
    
}
