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
    @IBOutlet private weak var orderImg: UIImageView!
    @IBOutlet private weak var orderItemDesc: UILabel!
    @IBOutlet private weak var deleteBtn: UIButton!
    @IBOutlet private weak var orderItemTitleLabel: UILabel!
    var product:Product?
    var didPressDeleteBtn : (()->Void)?
    var disposeBag = DisposeBag()
    
    
    var orderImgValue : String? {
        didSet{
            orderImg.cornerRadius = 37.5
            orderImg.sd_setImage( with: URL(string: orderImgValue!) , placeholderImage: #imageLiteral(resourceName: "placeHolder"))
        }
    }
    
    var orderItemValue : String?{
        didSet{
            orderItemDesc.text = returnPrice(price: Double(orderItemValue ?? "0.0") ?? 0.0)
            
        }
    }
    
    var orderItemTitleValue : String?{
        didSet{
            orderItemTitleLabel.text = orderItemTitleValue
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
    
    
    @IBAction func removeProduct(_ sender: Any) {
//        DbManager.getInstance(appDelegate: UIApplication.shared.delegate as! AppDelegate).removeFavProduct(product: product!)
        didPressDeleteBtn!()
    }
    
}
