//
//  CatoegorieTableViewCell.swift
//  BetterBuy
//
//  Created by Mohamed Adel on 5/25/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit

class CatoegorieTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryLB: UILabel!
    @IBOutlet weak var categoryImg: UIImageView!
    static var cellIdentifier = "categorycell"
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
        contentView.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }    
    func configureCell(_ categoryName:String)
    {
        categoryLB.text = categoryName
        if categoryName == "Kid"{
            categoryImg.image = UIImage(named: "kidBanner")
        }
        else if categoryName == "Men"{
            categoryImg.image = UIImage(named: "menImg")
        }
        else if categoryName == "Women"{
            categoryImg.image = UIImage(named: "womenImgBanner")
        }
        else if categoryName == "Sale"{
            categoryImg.image = UIImage(named: "women2")
        }
        
    }
    
    
}
