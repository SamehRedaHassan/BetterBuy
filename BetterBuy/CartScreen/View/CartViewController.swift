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
    
    @IBOutlet private weak var cartTableView: UITableView!
    @IBOutlet weak var subTotalLb: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    //maybe make it random from 1 to 70 EG
    @IBOutlet weak var shippingLb: UILabel!
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
        viewModel?.retieveProductsInCart()
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

        viewModel?.cartObservabel.bind(to: cartTableView.rx.items(cellIdentifier: String(describing: ProductTableViewCell.cellIdentifier), cellType: ProductTableViewCell.self)) {  row, element, cell in
            cell.prodTitle = element.title
            cell.productDesc = element.description
            cell.currency = "EG"
            cell.prodPrice = element.variants?[0].price
            cell.count = String(describing: element.count)
        }.disposed(by: disposeBag)
    }
}
