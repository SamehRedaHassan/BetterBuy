//
//  SizeCollectionViewCell.swift
//  BetterBuy
//
//  Created by nada elmasry on 6/1/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit

class SizeCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var sizeLable: UILabel!
    var sizeTxt : String? {
        didSet{
            sizeLable.text = sizeTxt
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
