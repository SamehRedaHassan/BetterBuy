//
//  ProductTableViewCell.swift
//  BetterBuy
//
//  Created by Mohamed Adel on 5/31/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProductTableViewCell: UITableViewCell {
    
    static var cellIdentifier : String = "ProductTableViewCell"
    @IBOutlet private weak var productImg: UIImageView!
    var productImgStr : String?{
        didSet{
            guard let productImage = productImgStr else {return}
            guard let url = URL(string:productImage) else {
                print("cannot generate url")
                return
            }
            productImg.sd_setImage(with: url, placeholderImage: UIImage(named: "placeHolder"))
        }
    }
    @IBOutlet private weak var productTitle: UILabel!
    var prodTitle : String?{
        didSet{
            self.productTitle.text = self.prodTitle?.capitalized
        }
    }
    @IBOutlet private weak var productDescLB: UILabel!
    var productDesc : String?{
        didSet{
            self.productDescLB.text = self.productDesc
        }
    }
    @IBOutlet private weak var productPrice: UILabel!
    var prodPrice : String?{
        didSet{
            self.productPrice.text = returnPrice(price: Double(self.prodPrice ?? "0.0") ?? 0.0)
        }
    }
    @IBOutlet private weak var currencyLB: UILabel!
    var currency : String?{
        didSet{
            self.currencyLB.text = ""
        }
    }
    @IBOutlet private weak var plusBtn: UIButton!
    //var add : (()->Void)
    @IBOutlet private weak var countLB: UILabel!
    var count : String?{
        didSet{
            self.countLB.text = self.count
        }
    }
    @IBOutlet private weak var minusBtn: UIButton!
    let disposeBag = DisposeBag()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        plusBtn.rx.tap.bind{
            (self.add ?? {})()
        }.disposed(by: disposeBag)
        minusBtn.rx.tap.bind{
            (self.minus ?? {})()
        }.disposed(by: disposeBag)
    }
    var add : (()->Void)?
    var minus : (()->Void)?
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
