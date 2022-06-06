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
    
    //MARK: - Properties
  //  weak var coordinator : Coordinator!
   private var viewControllers: [UIViewController] = []
    private  var viewModel : SlideContainerViewModelType!

    // MARK: - Life Cycle
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let firstPageViewModel = PageOneViewModel(coordinator:viewModel.coordinator)
         let firstPageVC = PageOneViewController(viewModel: firstPageViewModel)

         let secondPageVC = PageTwoViewController(nibName:  String(describing: PageTwoViewController.self), bundle: nil)
        
         let thirdPageVC = PageThreeViewController(nibName: String(describing: PageThreeViewController.self), bundle: nil)
        let controllers: [UIViewController] = [thirdPageVC, secondPageVC ,firstPageVC]
        self.viewControllers = controllers
        datasource = self
    }
    
    //MARK: - Functions
    func injectViewModel(viewModel : SlideContainerViewModelType){
        self.viewModel = viewModel
    }
    
    
    func numberOfControllersInLiquidSwipeContainer(_ liquidSwipeContainer: LiquidSwipeContainerController) -> Int {
        return viewControllers.count
    }
    
    func liquidSwipeContainer(_ liquidSwipeContainer: LiquidSwipeContainerController, viewControllerAtIndex index: Int) -> UIViewController {
        return viewControllers[index]
    }
}
