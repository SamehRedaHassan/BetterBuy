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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }    
    func configureCell(_ categoryName:String)
    {
        categoryLB.text = categoryName
        categoryImg.image = UIImage(named: "WomenCategoryImg")
    }
    
    
}
