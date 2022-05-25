//
//  ViewController.swift
//  BetterBuy
//
//  Created by Mohamed Adel on 5/22/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    //MARK: variables
    var viewModel : SplashViewModel?
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.goToSplashScreen()
    }
    
    //MARK: Functions
    

}

