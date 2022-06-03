//
//  WishListViewController.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/26/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit

class WishListViewController: UIViewController {
    //MARK: IBOutlet
    @IBOutlet weak var wishListtableView: UITableView!
    @IBOutlet weak var navBar: NavBar!
    
    //MARK: Properties
    var viewModel : WishListViewModelType!
    
    
    // MARK: - Life Cycle
    convenience init() {
        self.init(wishListViewModel: nil)
    }

    init(wishListViewModel: WishListViewModelType?) {
        self.viewModel = wishListViewModel
        super.init(nibName:String(describing: WishListViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureTableView()
    }
    
   //MARK: Functions
   private func configureTableView() {
        wishListtableView.delegate = self
        wishListtableView.dataSource = self
   }
    private func configureNavBar() {
        navBar.injectCoordinator(coordinator: viewModel.coordinator)
    }
}

//MARK: Extension
extension WishListViewController : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.orders.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.register(UINib.init(nibName: "WishListTableViewCell", bundle: nil), forCellReuseIdentifier: "WishListTableViewCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "WishListTableViewCell", for: indexPath) as! WishListTableViewCell
        cell.wishListItemNameLabel.text = "\(viewModel.orders[indexPath.row].id ?? 0)"
        cell.wishListItemNameDescLabel.text = viewModel.orders[indexPath.row].totalPrice
        return cell
        
    }
}
