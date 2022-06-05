//
//  CartViewController.swift
//  BetterBuy
//
//  Created by Mohamed Adel on 5/29/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit
import RxSwift

class CartViewController: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet private weak var navBar: NavBar!
    @IBOutlet private weak var checkoutButton: UIButton!
    
    //MARK: - Properties
    private var viewModel : CartViewModelType!
    private let disposeBag = DisposeBag()
    
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
        bindUI()
    }
    
    //MARK: - Functions
    private func setupNavBar(){
        navBar.injectCoordinator(coordinator: viewModel.coordinator)
    }
    
    private func bindUI(){
        checkoutButton.rx.tap.subscribe { [weak self] tap in
            guard let self = self else {return}
            self.viewModel.proceedToCheckout()
        }.disposed(by: disposeBag)

    }
}
