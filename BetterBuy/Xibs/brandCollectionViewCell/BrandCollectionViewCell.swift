//
//  BrandCollectionViewCell.swift
//  BetterBuy
//
//  Created by user222682 on 6/2/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit

class BrandCollectionViewCell: UICollectionViewCell {
    //MARK: - IBOutlet
    @IBOutlet private weak var brandImageView: UIImageView!
    @IBOutlet private weak var brandLabel: UILabel!
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - Life Cycle
    var brandImageUrl : String? {
        didSet{
            guard let brandImageUrl = brandImageUrl else {return}
            guard let url = URL(string:brandImageUrl) else {
                print("cannot generate url")
                return
            }
            brandImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeHolder"))
            
        }
    }
    
    var brandName : String? {
        didSet{
            brandLabel.text = brandName
        }
    }
}
