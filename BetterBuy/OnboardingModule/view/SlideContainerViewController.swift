//
//  SlideContainerViewController.swift
//  BetterBuy
//
//  Created by user222682 on 5/26/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit
import liquid_swipe


class SlideContainerViewController: LiquidSwipeContainerController, LiquidSwipeContainerDataSource {
    
    //MARK: - Variables
    var coordinator : AppCoordinator?
    
    var viewControllers: [UIViewController] = {
        let firstPageVC = PageOneViewController(nibName: String(describing: PageOneViewController.self), bundle: nil)

        let secondPageVC = PageTwoViewController(nibName:  String(describing: PageTwoViewController.self), bundle: nil)
        let thirdPageVC = PageThreeViewController(nibName: String(describing: PageThreeViewController.self), bundle: nil)
        var controllers: [UIViewController] = [thirdPageVC, secondPageVC ,firstPageVC]

        return controllers
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let lastCoordinator = viewControllers[2] as! PageOneViewController
        lastCoordinator.coordinator = coordinator
        datasource = self
    }
    
    //MARK: - Functions
    func numberOfControllersInLiquidSwipeContainer(_ liquidSwipeContainer: LiquidSwipeContainerController) -> Int {
        return viewControllers.count
    }
    
    func liquidSwipeContainer(_ liquidSwipeContainer: LiquidSwipeContainerController, viewControllerAtIndex index: Int) -> UIViewController {
        return viewControllers[index]
    }
}
