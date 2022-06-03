//
//  ProductCell.swift
//  BetterBuy
//
//  Created by Mohamed Adel on 5/26/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit
import RxCocoa

class ProductCell: UICollectionViewCell {
    
    //MARK: - IBOulet
    @IBOutlet private weak var productTitleLB: UILabel!
    @IBOutlet private weak var productPriceLB: UILabel!
    @IBOutlet private weak var productDesLB: UILabel!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var productImg: UIImageView!
    
    
    //MARK: - internal property
    static let cellIdentifier = "ProductCell"
    var productImage : String? {
        didSet{
            guard let productImage = productImage else {return}
            guard let url = URL(string:productImage) else {
                print("cannot generate url")
                return
            }
            productImg.sd_setImage(with: url, placeholderImage: UIImage(named: "placeHolder"))
        }
    }
    var productTitle : String?{
        didSet{
            self.productTitleLB.text = self.productTitle
        }
    }
    var productPrice : String?{
        didSet{
            self.productPriceLB.text = self.productPrice
        }
    }
    var productDescription:String?{
        didSet{
            self.productDesLB.text = self.productDescription
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 20
    }

    @IBAction func addProductToWishList(_ sender: Any) {
        
    }
}
