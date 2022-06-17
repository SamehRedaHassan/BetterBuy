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
        //goToSettingsPage()
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
        let orderListViewModel = OrderListViewModel(db: DbManager.getInstance(appDelegate: UIApplication.shared.delegate as! AppDelegate), coordinator: self)
        let orderListViewController = OrderListViewController(viewModel: orderListViewModel)
        
        navigationController.pushViewController(orderListViewController, animated: true)
    }
    


    func goToProductDetailsPage(product: Product){
        let productDetailsViewModel = DetailsViewModel(product: product, db:  DbManager.getInstance(appDelegate: UIApplication.shared.delegate as! AppDelegate), cartDb: CartDBManager.getInstance(appDelegate: UIApplication.shared.delegate as! AppDelegate), coordinator: self)
        let productDetailsViewController = DetailsViewController(viewModel: productDetailsViewModel)
        navigationController.pushViewController(productDetailsViewController, animated: true)
    }
    
    func goToLoginPage(){
        let loginViewModel = LoginViewModel(coordinator: self)
        let loginViewController = LoginViewController(viewModel: loginViewModel)
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
    func goToCartPage(){
        let cartViewModel = CartViewModel(coordinator: self, cartCoreData:  CartDBManager.getInstance(appDelegate: UIApplication.shared.delegate as! AppDelegate))
        let cartViewController = CartViewController(cartViewModel: cartViewModel)
        navigationController.pushViewController(cartViewController, animated: true)
    }
    
    func goToSettingsPage(){
        let settingsViewModel = SettingViewModel(coordinator: self, cartDB: CartDBManager.getInstance(appDelegate: UIApplication.shared.delegate as! AppDelegate))
        let settingsViewController = SettingsViewController(settingsViewModel: settingsViewModel)
        navigationController.pushViewController(settingsViewController, animated: true)
    }
    
    func popViewController(){
        self.navigationController.popViewController(animated: true)
    }
    func proceedToCheckout(withSubtotal : Double , address : Address, order : PostOrder) {
        let paymentViewModel = PaymentViewModel(coordinator: self, address: address, bagSubtotal: withSubtotal, order: order)
        let paymentViewController = PaymentViewController(paymentViewModel: paymentViewModel)
        navigationController.pushViewController(paymentViewController, animated: true)
    }
    
    
    func goToLocationScreen(){
        let locationViewModel = AddressViewModel(coordinator: self)
        let locationViewController = AddressViewController(addressViewModel: locationViewModel)
        navigationController.pushViewController(locationViewController, animated: true)
    }
    
    func navigateToSearchScreen(){
        let searchViewModel = SearchViewModel(coordinator: self)
        let searchViewController = SearchViewController(searchViewModel: searchViewModel)
        navigationController.pushViewController(searchViewController, animated: true)
    }
    
    func navigateToAddressesScreen(withSubtotal: Double, order : PostOrder) {
        let addressesViewModel = AddressesViewModel(coordinator: self , subTotal : withSubtotal , order : order)
        let addressesViewController = AddressesViewController(addressesViewModel: addressesViewModel)
        navigationController.pushViewController(addressesViewController, animated: true)
    }
    
}
