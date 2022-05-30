//
//  ProductCell.swift
//  BetterBuy
//
//  Created by Mohamed Adel on 5/26/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var productTitleLB: UILabel!
    @IBOutlet weak var productPriceLB: UILabel!
    @IBOutlet weak var productDesLB: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var productImg: UIImageView!
    static let cellIdentifier = "ProductCell"
    override func awakeFromNib() {
        super.awakeFromNib()
    
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 20
    }

    @IBAction func addProductToWishList(_ sender: Any) {
        
    }
}
