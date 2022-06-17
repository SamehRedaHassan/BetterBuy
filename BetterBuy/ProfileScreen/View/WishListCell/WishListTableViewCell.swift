//
//  WishListTableViewCell.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/26/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit

class WishListTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK: IBOutlets
    @IBOutlet private weak var wishListItemNameLabel: UILabel!
    @IBOutlet private weak var wishListItemNameDescLabel: UILabel!
    
    var orderID : String? {
        didSet{
            wishListItemNameLabel.text = "Order id: " + (orderID ?? "null")
        }
    }
    
    var orderPrice : String? {
        didSet{
            wishListItemNameDescLabel.text = "Order price: " + returnPrice(price: Double(orderPrice ?? "0.0") ?? 0.0)
        }
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
