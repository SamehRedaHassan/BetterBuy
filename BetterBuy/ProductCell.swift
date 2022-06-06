//
//  ProductCell.swift
//  BetterBuy
//
//  Created by Mohamed Adel on 5/26/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProductCell: UICollectionViewCell {
    
    //MARK: - IBOulet
    @IBOutlet private weak var productTitleLB: UILabel!
    @IBOutlet private weak var productPriceLB: UILabel!
    @IBOutlet private weak var productDesLB: UILabel!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var productImg: UIImageView!
    @IBOutlet private weak var favouriteBtn: UIButton!
    
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
            self.productTitleLB.text = productTitle
        }
    }
    
    var productPrice : String?{
        didSet{
            guard let price = self.productPrice else {return}
            self.productPriceLB.text = "EG" + price
        }
    }
    
    var productDescription:String?{
        didSet{
            self.productDesLB.text = self.productDescription
        }
    }
    
    var isFavourite:Bool = false{
        didSet
        {
            if self.isFavourite{
                self.favouriteBtn.setBackgroundImage(UIImage(systemName: "heart.circle.fill"), for: .normal)
            }
            else{
                self.favouriteBtn.setBackgroundImage(UIImage(systemName: "heart.circle"), for: .normal)
            }
        }
    }
    
    var isFavouriteButtonHidden = false {
        didSet{
            favouriteBtn.isHidden = isFavouriteButtonHidden
        }
    }
    
   private let disposeBag = DisposeBag()
    var addToFav : (()->Void)?
    var removeFav : (()->Void)?
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.favouriteBtn.isHidden = !UserDefaults.getLoginStatus()
      //  containerView.layer.masksToBounds = true
      //  containerView.layer.cornerRadius = 20
        
        favouriteBtn.rx.tap.bind{
            if self.isFavourite == false{
                self.favouriteBtn.setBackgroundImage(UIImage(systemName: "heart.circle.fill"), for: .normal)
                self.addToFav?()
            }
            else{
                self.favouriteBtn.setBackgroundImage(UIImage(systemName: "heart.circle"), for: .normal)
                self.removeFav?()
            }
        }.disposed(by: disposeBag)
    }

}
