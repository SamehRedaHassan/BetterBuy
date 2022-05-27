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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.register(UINib.init(nibName: "WishListTableViewCell", bundle: nil), forCellReuseIdentifier: "WishListTableViewCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "WishListTableViewCell", for: indexPath) as! WishListTableViewCell
        cell.wishListItemNameLabel.text = "Addidas Shoes"
        cell.wishListItemNameDescLabel.text = "German manufacturer of athletic shoes and apparel and sporting goods"
        return cell
        
    }
}
