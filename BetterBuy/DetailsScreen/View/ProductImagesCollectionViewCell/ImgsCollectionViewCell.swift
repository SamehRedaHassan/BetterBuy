//
//  ImgsCollectionViewCell.swift
//  BetterBuy
//
//  Created by nada elmasry on 6/1/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit

class ImgsCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var img: UIImageView!
    
    var imgValue : String?{
        didSet{
            img.sd_setImage(with: URL(string: imgValue ?? ""), placeholderImage: #imageLiteral(resourceName: "placeHolder"))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
