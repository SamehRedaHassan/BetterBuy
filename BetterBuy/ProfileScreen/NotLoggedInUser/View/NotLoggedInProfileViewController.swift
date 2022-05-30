//
//  NotLoggedInProfileViewController.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/27/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit

class NotLoggedInProfileViewController: UIViewController {
    
    //MARK: OutLets
    

    //MARK: variables
    var viewModel : NotLoggedInViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    //MARK: IBActions
    
    @IBAction func signUpBtn(_ sender: Any) {
        viewModel?.goToRegisterScreen()
    }
    
    @IBAction func LoginBtn(_ sender: Any) {
        viewModel?.goToLoginScreen()
    }
    
    
}
