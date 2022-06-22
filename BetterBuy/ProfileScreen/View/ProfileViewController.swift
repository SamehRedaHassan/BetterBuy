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

class ProfileViewController: BaseViewController {
    
    @IBOutlet weak var settingsBtn: UIButton!
    //MARK: IBOutlets
    //  @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var profileTableView: UITableView!
    
    @IBOutlet weak var notLoggedInView: UIView!
    
    //MARK: variables
    private var viewModel : ProfileViewModelType?
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
        settingsBtn.isHidden = !UserDefaults.getLoginStatus()
        userName.text = UserDefaults.getUserObject()?.firstName
        viewModel?.getProfileDetails()
        viewModel?.getCustomerOrders()
        viewModel?.getAllFavourites()
        viewModel?.didFetchData = {[weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.profileTableView.reloadData()
            }
        }
        
        viewModel?.isLoading
            .distinctUntilChanged()
            .drive(onNext: { [weak self] (isLoading) in
                guard let self = self else { return }
                self.killLoading()
                if isLoading {
                    self.loading()
                }
            }).disposed(by: disposeBag)
        
        settingsBtn.rx.tap.subscribe {  [weak self] event in
            guard let self = self else {return}
            self.viewModel?.goToSettingsScreen()
            
        }.disposed(by: disposeBag)
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.getCustomerOrders()
        viewModel?.getAllFavourites()
        profileTableView.reloadData()
        super.viewWillAppear(animated)
        setupLoggedInView()
    }
    
    func registerTableView() {
        profileTableView.delegate = self
        profileTableView.dataSource = self
    }
    private func setupLoggedInView(){
        notLoggedInView.isHidden = UserDefaults.getLoginStatus()
    }
    //MARK: - IBActions
    
    @IBAction func navigateToLogin(_ sender: UIButton) {
        viewModel?.goToLoginScreen()
    }
    
    @IBAction func navigateToRegister(_ sender: UIButton) {
        viewModel?.goToRegisterScreen()
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
            cell.orderItemTitleValue = viewModel?.favourites?[indexPath.row].title
            cell.orderItemValue = viewModel?.favourites?[indexPath.row].variants?[0].price
            cell.didPressDeleteBtn = {
                self.viewModel?.deleteProductFromFav(product: (self.viewModel?.favourites?[indexPath.row])!)
                self.viewModel?.favourites?.remove(at: indexPath.row)
                DispatchQueue.main.async{
                    self.profileTableView.reloadData()
                }
            }
            
            
            return cell
        }
        
        
        if (indexPath.section == 0) {
            tableView.register(UINib.init(nibName: "WishListTableViewCell", bundle: nil), forCellReuseIdentifier: "WishListTableViewCell")
            let cell = tableView.dequeueReusableCell(withIdentifier: "WishListTableViewCell", for: indexPath) as! WishListTableViewCell
            print(viewModel?.orders?[indexPath.row])
            cell.orderPrice = viewModel?.orders?[indexPath.row].total_line_items_price
            cell.orderID = "\(viewModel?.orders?[indexPath.row].id ?? 0)"
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
            sectionName = "Orders"
        default:
            sectionName = ""
        }
        return sectionName
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 60))
        let myButton = UIButton(type: .custom)
        
        if(section == 1 ){
            if(viewModel?.favourites?.count == 0 ){
                myButton.setTitle("No favourites yet", for: .normal)
                myButton.isEnabled = false
            } else {
                myButton.setTitle("View more", for: .normal)
                myButton.isEnabled = true
            }
        } else {
            if(viewModel?.orders?.count == 0 ){
                myButton.setTitle("No orders yet", for: .normal)
                myButton.isEnabled = false
            } else {
                myButton.setTitle("View more", for: .normal)
                myButton.isEnabled = true
            }
        }
        
        
        if (section == 1)
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
        print("my order")
        viewModel?.goToOrderListScreen()
    }
    
    @objc func myWishListAction(_ sender : AnyObject) {
        print("my wish")
        viewModel?.goToWishListScreen()
    }
    
}
