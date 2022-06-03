//
//  CartViewController.swift
//  BetterBuy
//
//  Created by Mohamed Adel on 5/29/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var navBar: NavBar!
    
    //MARK: - Properties
    private var viewModel : CartViewModelType!

    
    // MARK: - Life Cycle
    convenience init() {
        self.init(cartViewModel: nil)
    }

    init(cartViewModel: CartViewModelType?) {
        self.viewModel = cartViewModel
        super.init(nibName: "CartView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    
    //MARK: - Functions
    private func setupNavBar(){
        navBar.injectCoordinator(coordinator: viewModel.coordinator)
    }
}
