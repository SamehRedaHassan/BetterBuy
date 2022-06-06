//
//  OrderListViewController.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/26/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class OrderListViewController: UIViewController {

    //The Array here should come from the CoreData
    
    @IBOutlet private weak var navBar: NavBar!
    @IBOutlet private weak var orderTableView: UITableView!
    
    
    
    //MARK: variables
    var viewModel : OrderlistViewModelType?
    var disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    convenience init() {
        self.init(viewModel: nil)
    }

    init(viewModel: OrderlistViewModelType?) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: OrderListViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getAllFavourites()
        configTableView()
        configureTabBar()
        
        
    }

    func configTableView(){
        orderTableView.delegate = self
        orderTableView.dataSource = self
    }
    private func configureTabBar(){
        navBar.coordinator = viewModel?.coordinator
    }
   
}

extension OrderListViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.orders?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib.init(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderTableViewCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath) as! OrderTableViewCell
        cell.orderImgValue =  viewModel?.orders![indexPath.row].images?[0].src
        //cell.orderImg.cornerRadius = 37.5
        cell.orderItemTitleValue = viewModel?.orders?[indexPath.row].title
        cell.orderItemValue = viewModel?.orders![indexPath.row].variants?[0].price
        cell.product = viewModel?.orders![indexPath.row]
        cell.didPressDeleteBtn = {
            self.viewModel?.deleteProductFromFavourite(product: (self.viewModel?.orders?[indexPath.row])!)
            self.viewModel?.orders!.remove(at: indexPath.row)
            DispatchQueue.main.async {
                self.orderTableView.reloadData()
            }
            
        }

        return cell
    }
    
    
    
}
