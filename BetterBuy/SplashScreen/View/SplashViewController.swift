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
    private var viewModel : SplashViewModelType!

    
    // MARK: - Life Cycle
    convenience init() {
        self.init(splashViewModel: nil)
    }

    init(splashViewModel: SplashViewModelType?) {
        self.viewModel = splashViewModel
        super.init(nibName: "SplashScreen", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.navigateToHomeOrIntro()
    }
    
    //MARK: Functions
    

}

