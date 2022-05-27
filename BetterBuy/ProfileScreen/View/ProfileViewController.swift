//
//  ProfileViewController.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/25/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileTableView: UITableView!
    
    
    //MARK: variables
    var viewModel : ProfileViewModel?
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        
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
        if(section == 0){
            return 2
        }
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            tableView.register(UINib.init(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderTableViewCell")
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath) as! OrderTableViewCell
            cell.orderImg.image = #imageLiteral(resourceName: "img4")
            cell.orderImg.cornerRadius = 37.5
            cell.orderItemTitleLabel.text = "Addidas Shoes"
            cell.orderItemDesc.text = "German manufacturer of athletic shoes and apparel and sporting goods"
            return cell
        }
        
        
        if (indexPath.section == 1) {
            tableView.register(UINib.init(nibName: "WishListTableViewCell", bundle: nil), forCellReuseIdentifier: "WishListTableViewCell")
            let cell = tableView.dequeueReusableCell(withIdentifier: "WishListTableViewCell", for: indexPath) as! WishListTableViewCell
            cell.wishListItemNameLabel.text = "Addidas Shoes"
            cell.wishListItemNameDescLabel.text = "German manufacturer of athletic shoes and apparel and sporting goods"
            return cell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        let sectionName: String
        switch section {
            case 0:
                sectionName = "Orders"
            case 1:
                sectionName = "Wish List"
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
        if (section == 0) //else { return nil } // Can remove if want button for all sections
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
