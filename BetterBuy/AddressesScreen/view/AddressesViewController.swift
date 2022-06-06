//
//  AddressesViewController.swift
//  BetterBuy
//
//  Created by user222682 on 6/5/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit
import RxSwift
class AddressesViewController: UIViewController {
    //MARK: IBOutlets
  
    @IBOutlet weak var navBar: NavBar!
    @IBOutlet weak var addressTableView: UITableView!
    @IBOutlet weak var addAddressButton: UIButton!
    
    //MARK: variables
    private var viewModel : AddressesViewModelType!
    private let disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    convenience init() {
        self.init(addressesViewModel: nil)
    }

    init(addressesViewModel: AddressesViewModelType?) {
        self.viewModel = addressesViewModel
        super.init(nibName: String(describing: AddressesViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
        configureNavBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getAddresses()
    }

    //MARK: Functions
    private func configureUI(){
        addAddressButton.rx.tap.bind {[weak self] event in
            self?.viewModel.navigateToAddAddress()
        }.disposed(by: disposeBag)
    }
    private func configureNavBar() {
        navBar.coordinator = viewModel.coordinator
    }
    
    private func configureTableView(){
        addressTableView.register(UINib(nibName: String(describing: AddressTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: AddressTableViewCell.self))
        
        viewModel.addressesResponse.bind(to: addressTableView.rx.items(cellIdentifier: String(describing: AddressTableViewCell.self), cellType: AddressTableViewCell.self)) {( row, model, cell) in
            cell.selectionStyle = .none
            cell.address = "\(model.address1 ?? "")  \(model.city ?? "") \(model.country ?? "")"
        }.disposed(by: disposeBag)
        
        addressTableView.rx.itemSelected.bind { [weak self] index in
            self?.viewModel.navigateCheckout()
        }.disposed(by: disposeBag)
        
    }

}
