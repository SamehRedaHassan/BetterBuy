//
//  TabBarController.swift
//  BetterBuy
//
//  Created by user222682 on 5/25/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//


import UIKit

class TabBarContoller: UITabBarController {

    var coordinator : AppCoordinator?
 
    
   
    let floatingTabbarView = FloatingBarView(["house", "rectangle.3.offgrid",  "person"])

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewModel = HomeViewModel()
        let profileViewModel = ProfileViewModel()
        

        let homeViewController = HomeViewController(homeViewModel: viewModel)
        
        let profileViewController = ProfileViewController(profileViewModel: profileViewModel)
        // Instantiate LoginViewModel
       
     //  let splashScreenViewModel = SplashViewModel()
      //  splashScreenViewModel.appCoordinator = AppCoordinator(navigationController: UINavigationController.init())
        // Set the ViewModel to ViewController
     //   splashScrViewController.viewModel = splashScreenViewModel
        // Push it.
        
        
        
        viewControllers = [


            createNavViewController(viewController: homeViewController, title: "", imageName: "house.fill"),

            createNavViewController(viewController: UIViewController(), title: "Categories", imageName: "flame.fill"),
            createNavViewController(viewController: profileViewController, title: "Profile", imageName: "rectangle.3.offgrid.fill")
        ]
        tabBar.isHidden = true

        setupFloatingTabBar()
    }

    private func createNavViewController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {

      //  viewController.navigationItem.title = title

        let navController = UINavigationController(rootViewController: viewController)
        navController.isNavigationBarHidden = true
      //  navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(systemName: imageName)

        return navController
    }

    func setupFloatingTabBar() {
        floatingTabbarView.delegate = self
        view.addSubview(floatingTabbarView)
        floatingTabbarView.centerXInSuperview()
        floatingTabbarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
    }
    
    func toggle(hide: Bool) {
        floatingTabbarView.toggle(hide: hide)
    }
}

extension TabBarContoller: FloatingBarViewDelegate {
    func did(selectindex: Int) {
        selectedIndex = selectindex
    }
}
