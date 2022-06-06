//
//  TabBarController.swift
//  BetterBuy
//
//  Created by user222682 on 5/25/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//


import UIKit

class TabBarContoller: UITabBarController {

    //MARK: - Properties
    var coordinatorr : Coordinator?
    let floatingTabbarView = FloatingBarView(["house", "rectangle.3.offgrid",  "person"])

    //MARK: - Life Cycle
    
    
    init(coordinator : Coordinator){
        self.coordinatorr = coordinator
        super.init(nibName: nil, bundle: nil)

    }
    
 
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        let viewModel = HomeViewModel(coordinator: self.coordinatorr!)
        let homeViewController = HomeViewController(homeViewModel: viewModel)
        
        let profileViewModel = ProfileViewModel(db: DbManager.getInstance(appDelegate: UIApplication.shared.delegate as! AppDelegate), coordinator: self.coordinatorr!)
        let profileViewController = ProfileViewController(profileViewModel: profileViewModel)
 
        let categoryViewModel = CategoryViewModel(coordinator: self.coordinatorr!)
        let categoryViewController = CategoryViewController(categoryViewModel: categoryViewModel)
        
        
        viewControllers = [


            createNavViewController(viewController: homeViewController, title: "", imageName: "house.fill"),

            createNavViewController(viewController: categoryViewController, title: "Categories", imageName: "flame.fill"),
            createNavViewController(viewController: profileViewController, title: "Profile", imageName: "rectangle.3.offgrid.fill")
        ]
        tabBar.isHidden = true

        setupFloatingTabBar()
    }

    
    func injectCoordinator(coordinator : Coordinator){
        self.coordinatorr = coordinator
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
