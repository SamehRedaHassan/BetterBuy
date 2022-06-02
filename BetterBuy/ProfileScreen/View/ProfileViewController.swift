//
//  ProfileViewController.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/25/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileTableView: UITableView!
    
    
    //MARK: variables
    var viewModel : ProfileViewModelType?
    private let disposeBag = DisposeBag()
    

    // MARK: - Life Cycle
    
    convenience init() {
        self.init(profileViewModel: nil)
    }

    init(profileViewModel: ProfileViewModelType?) {
        self.viewModel = profileViewModel
        super.init(nibName: String(describing: ProfileViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        viewModel?.getProfileDetails()
        viewModel?.getCustomerOrders()
        viewModel?.getAllFavourites()
        viewModel?.didFetchData = {[weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.profileTableView.reloadData()
            }
        }
       // configurePreviousOrdersTableView()
       // configureWishListTableView()
        //homeViewModel?.getCustomers()
    }
    
    
    func registerTableView() {
        profileTableView.delegate = self
        profileTableView.dataSource = self
    }

}


extension ProfileViewController : UITableViewDelegate , UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 1){
            return ((viewModel?.favourites?.count ?? 0) >= 2 ? 2 : viewModel?.favourites?.count) ?? 0
        }
        return ((viewModel?.customer?.ordersCount ?? 0) >= 4 ? 4 : viewModel?.customer?.ordersCount) ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 1){
            tableView.register(UINib.init(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderTableViewCell")
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath) as! OrderTableViewCell
            cell.orderImgValue = viewModel?.favourites?[indexPath.row].images?[0].src
            cell.orderImg.cornerRadius = 37.5
            cell.orderItemTitleLabel.text = viewModel?.favourites?[indexPath.row].title
            cell.orderItemDesc.text = viewModel?.favourites?[indexPath.row].variants?[0].price
            cell.deleteBtn.rx.tap.bind{
                self.viewModel?.deleteProductFromFav(product: (self.viewModel?.favourites?[indexPath.row])!)
            }.disposed(by: disposeBag)
            return cell
        }
        
        
        if (indexPath.section == 0) {
            tableView.register(UINib.init(nibName: "WishListTableViewCell", bundle: nil), forCellReuseIdentifier: "WishListTableViewCell")
            let cell = tableView.dequeueReusableCell(withIdentifier: "WishListTableViewCell", for: indexPath) as! WishListTableViewCell
            cell.wishListItemNameLabel.text = viewModel?.orders?[indexPath.row].totalPrice
            cell.wishListItemNameDescLabel.text = "\(viewModel?.orders?[indexPath.row].id ?? 0)"
            return cell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        let sectionName: String
        switch section {
            case 1:
                sectionName = "Wish List"
            case 0:
                sectionName = "Order"
            default:
                sectionName = ""
        }
        return sectionName
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
   

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
            let myButton = UIButton(type: .custom)

            myButton.setTitle("View more", for: .normal)
        if (section == 1) //else { return nil } // Can remove if want button for all sections
        {
            myButton.addTarget(self, action: #selector(myOrderAction(_:)), for: .touchUpInside)
        } else {
            myButton.addTarget(self, action: #selector(myWishListAction(_:)), for: .touchUpInside)
        }
        myButton.setTitleColor(UIColor.black, for: .normal)
        myButton.frame.size = CGSize(width: UIScreen.main.bounds.width, height: 7)
        myButton.titleLabel?.font =  .systemFont(ofSize: 12)
        myButton.titleLabel?.tintColor = .gray
        footerView.addSubview(myButton)
        return footerView;
        
    }

    @objc func myOrderAction(_ sender : AnyObject) {
        //MARK: HEREEEEEEEEEEEEEE
        print("my order")
        viewModel?.goToOrderListScreen()
    }
    
    @objc func myWishListAction(_ sender : AnyObject) {
        print("my wish")
        viewModel?.goToWishListScreen()
    }

}
