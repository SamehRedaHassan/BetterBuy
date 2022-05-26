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

        viewControllers = [
            createNavViewController(viewController: UIViewController(), title: "Home", imageName: "house.fill"),
            createNavViewController(viewController: UIViewController(), title: "Trending", imageName: "flame.fill"),
            createNavViewController(viewController: UIViewController(), title: "Settings", imageName: "rectangle.3.offgrid.fill")
        ]
        tabBar.isHidden = true

        setupFloatingTabBar()
    }

    private func createNavViewController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {

        viewController.navigationItem.title = title

        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem.title = title
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
