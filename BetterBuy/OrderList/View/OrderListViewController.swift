//
//  OrderListViewController.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/26/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit

class OrderListViewController: UIViewController {

    @IBOutlet weak var orderTableView: UITableView!
    
    //MARK: variables
    var viewModel : OrderListViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configTableView()
    }

    func configTableView(){
        orderTableView.delegate = self
        orderTableView.dataSource = self
    }
   
}

extension OrderListViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib.init(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderTableViewCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath) as! OrderTableViewCell
        cell.orderImg.image = #imageLiteral(resourceName: "img4")
        cell.orderImg.cornerRadius = 37.5
        cell.orderItemTitleLabel.text = "Addidas Shoes"
        cell.orderItemDesc.text = "German manufacturer of athletic shoes and apparel and sporting goods"
        return cell
    }
    
    
    
}
