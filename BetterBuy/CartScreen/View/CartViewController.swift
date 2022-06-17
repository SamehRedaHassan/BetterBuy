//
//  CartViewController.swift
//  BetterBuy
//
//  Created by Mohamed Adel on 5/29/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit
import RxSwift

class CartViewController: BaseViewController {
    //MARK: - IBOutlet
    @IBOutlet private weak var navBar: NavBar!
    @IBOutlet private weak var checkoutButton: UIButton!
    
    @IBOutlet weak var priceStack: UIStackView!
    @IBOutlet private weak var cartTableView: UITableView!
    @IBOutlet weak var subTotalLb: UILabel!
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
        //       cartTableView.translatesAutoresizingMaskIntoConstraints = false
        bindUI()
        viewModel?.retieveProductsInCart()
        
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkoutButton.isHidden = viewModel.noOrdersAvailable()
    }
    
    //MARK: - Functions
    private func setupNavBar(){
        navBar.injectCoordinator(coordinator: viewModel.coordinator)
    }
    
    @objc func emptyCart(notification: Notification) {
        viewModel.removeAllProductsFromCart()
        
    }

    private func bindUI(){
       
        NotificationCenter.default.addObserver(self, selector: #selector(self.emptyCart(notification:)), name: Notification.Name( "Order Placed Successfully"), object: nil)

        cartTableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: ProductTableViewCell.cellIdentifier)
        checkoutButton.rx.tap.subscribe { [weak self] tap in
            guard let self = self else {return}
            self.viewModel.proceedToCheckout()
        }.disposed(by: disposeBag)
        
        
        viewModel.isEmptyCollection.distinctUntilChanged().subscribe { [weak self] isEmpty in
            guard let self = self else{return}
            if(isEmpty.element ?? false){
                self.cartTableView.addSubview(self.getNoDataViewWith(image: UIImage(named: "noData")!, head: "No items Yet :("))
                self.checkoutButton.isHidden = true
                self.priceStack.isHidden = true
            }else {
                self.cartTableView.removeAllSubviews()
                self.checkoutButton.isHidden = false
                self.priceStack.isHidden = false
            }
        } .disposed(by: disposeBag)
        
        viewModel?.cartObservabel.bind(to: cartTableView.rx.items(cellIdentifier: String(describing: ProductTableViewCell.cellIdentifier), cellType: ProductTableViewCell.self)) {  row, element, cell in
            cell.selectionStyle = .none
            cell.prodTitle = element.title
            cell.productDesc = element.description
            cell.currency = "EG"
            cell.prodPrice = element.variants?[0].price
            cell.count = String(describing: element.count)
            cell.productImgStr = element.images?[0].src
            cell.add = { [weak self] in
                let count = self?.viewModel?.incrementProductCount(productId: String(describing: element.id!))
                cell.count = String(describing: count!)
                self?.viewModel?.updateTotalPrice()
                print("plus: \(String(describing: count!))")
            }
            cell.minus = { [weak self] in
                let count = self?.viewModel?.decrementProductCount(productId: String(describing: element.id!))
                cell.count = String(describing: count!)
                self?.viewModel?.updateTotalPrice()
                if(cell.count == "0"){
                    self?.viewModel?.removeProductCount(product: element)
                    //self?.viewModel?.isEmptyCollection.onNext()
                }
                print("minus: \(String(describing: count!))")
            }
            
            
        }.disposed(by: disposeBag)
        
        viewModel?.totalPriceObservabel.bind(to: subTotalLb.rx.text).disposed(by: disposeBag)
        
    }
}
