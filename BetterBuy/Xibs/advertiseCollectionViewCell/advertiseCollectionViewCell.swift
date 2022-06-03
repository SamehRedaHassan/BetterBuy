//
//  advertiseCollectionViewCell.swift
//  BetterBuy
//
//  Created by user222682 on 5/28/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit
import SDWebImage


class advertiseCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var brandImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   var brandImageUrl : String? {
           didSet{
               guard let brandImageUrl = brandImageUrl else {return}
               guard let url = URL(string:brandImageUrl) else {
                
                   print("cannot generate url")
                   return
               }
               brandImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeHolder"))

           }
       }
    
    var brandLitteralImage : String? {
           didSet{
               guard let brandLitteralImage = brandLitteralImage else {return}
               brandImage.image = UIImage(named: brandLitteralImage)

           }
       }

    
}
