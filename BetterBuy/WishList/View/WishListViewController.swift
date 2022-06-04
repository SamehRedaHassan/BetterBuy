//
//  WishListViewController.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/26/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit

class WishListViewController: UIViewController {
    @IBOutlet weak var wishListtableView: UITableView!
    
    //MARK: variables
    var viewModel : WishListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    func configureTableView() {
        wishListtableView.delegate = self
        wishListtableView.dataSource = self
    }
}


extension WishListViewController : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.orders.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.register(UINib.init(nibName: "WishListTableViewCell", bundle: nil), forCellReuseIdentifier: "WishListTableViewCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "WishListTableViewCell", for: indexPath) as! WishListTableViewCell
        cell.orderID = "\(viewModel?.orders[indexPath.row].id ?? 0)"
        cell.orderPrice = viewModel?.orders[indexPath.row].totalPrice
        return cell
        
    }
}
