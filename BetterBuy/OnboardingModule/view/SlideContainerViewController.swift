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
    
    var viewControllers: [UIViewController] = {
        let firstPageVC = PageOneViewController(nibName: String(describing: PageOneViewController.self), bundle: nil)
        let secondPageVC = PageTwoViewController(nibName:  String(describing: PageTwoViewController.self), bundle: nil)
        let thirdPageVC = PageThreeViewController(nibName: String(describing: PageThreeViewController.self), bundle: nil)
        var controllers: [UIViewController] = [thirdPageVC, secondPageVC ,firstPageVC]

        return controllers
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datasource = self
    }

    func numberOfControllersInLiquidSwipeContainer(_ liquidSwipeContainer: LiquidSwipeContainerController) -> Int {
        return viewControllers.count
    }
    
    func liquidSwipeContainer(_ liquidSwipeContainer: LiquidSwipeContainerController, viewControllerAtIndex index: Int) -> UIViewController {
        return viewControllers[index]
    }
    
    

}
