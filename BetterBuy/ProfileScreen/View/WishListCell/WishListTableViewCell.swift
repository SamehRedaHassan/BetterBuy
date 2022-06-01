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
    @IBOutlet weak var wishListItemNameLabel: UILabel!
    @IBOutlet weak var wishListItemNameDescLabel: UILabel!
    
    var wishListItemNameValue : String? {
        didSet{
            wishListItemNameLabel.text = wishListItemNameValue
        }
    }
    
    var wishListItemNameDescValue : String? {
        didSet{
            wishListItemNameDescLabel.text = wishListItemNameDescValue
        }
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
