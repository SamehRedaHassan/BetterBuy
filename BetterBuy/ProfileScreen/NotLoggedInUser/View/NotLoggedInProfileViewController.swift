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
    var viewModel : NotLoggedInViewModelType!
    
    
    
    
    // MARK: - Life Cycle
    convenience init() {
        self.init(notLoggedInViewModel: nil)
    }

    init(notLoggedInViewModel: NotLoggedInViewModelType?) {
        self.viewModel = notLoggedInViewModel
        super.init(nibName: String(describing: NotLoggedInProfileViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    //MARK: IBActions
    @IBAction func signUpBtn(_ sender: Any) {
        viewModel.goToRegisterScreen()
    }
    
    @IBAction func LoginBtn(_ sender: Any) {
        viewModel.goToLoginScreen()
    }
    
    
}
