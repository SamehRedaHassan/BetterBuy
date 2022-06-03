//
//  OrderTableViewCell.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/26/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class OrderTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    
    //MARK:IBOutlets
    @IBOutlet weak var orderImg: UIImageView!
    @IBOutlet weak var orderItemDesc: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var orderItemTitleLabel: UILabel!

    var disposeBag = DisposeBag()
    
    
    var orderImgValue : String? {
        didSet{
            orderImg.sd_setImage( with: URL(string: orderImgValue!) , placeholderImage: #imageLiteral(resourceName: "placeHolder"))
        }
    }
    
    var orderItemValue : String?{
        didSet{
            orderItemDesc.text = orderImgValue
        }
    }
    
    var orderItemTitleValue : String?{
        didSet{
            orderItemTitleLabel.text = orderImgValue
        }
    }
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    typealias deletType = (Product) -> Void
//    func onClick(closure : deletType){
//        deleteBtn.rx.tap.bind{
//            closure(product)
//        }.disposed(by: disposeBag)
//    }
    
    
    
}
