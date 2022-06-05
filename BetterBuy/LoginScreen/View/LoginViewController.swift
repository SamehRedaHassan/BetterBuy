//
//  LoginViewController.swift
//  BetterBuy
//
//  Created by Mohamed Adel on 5/29/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    //MARK: - IBOutlets

    @IBOutlet weak var emailTxtView: UITextField!
    @IBOutlet weak var passwordTxtView: UITextField!
    //MARK: - Properties
    var viewModel : LoginViewModelType?
    
    
    // MARK: - Life Cycle
    convenience init() {
        self.init(viewModel: nil)
    }

    init(viewModel: LoginViewModelType?) {
        self.viewModel = viewModel
        super.init(nibName: "LoginView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTxtView.addBottomBorder()
        passwordTxtView.addBottomBorder()
    }
    
    //MARK: - IBAction
    @IBAction func loginButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func navigateToSignup(_ sender: UIButton) {
        viewModel?.navigateToSignup()
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        viewModel?.goBack()
    }
}
