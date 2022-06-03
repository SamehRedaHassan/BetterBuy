//
//  NavBar.swift
//  BetterBuy
//
//  Created by user222682 on 5/28/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit
@IBDesignable
class NavBar: UIView {
    //MARK: - Properties
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var cartButton: UIButton!
    @IBOutlet private weak var favouriteButton: UIButton!
    
    //MARK: -Properties
    let nibName = "NavBar"
    var coordinator : Coordinator?
    
    @IBInspectable
    var isBackBtnHidden: Bool {
        get {
            return self.backButton.isHidden
        }
        set {
            self.backButton.isHidden = newValue
        }
    }
    
    @IBInspectable
    var isSearchBtnHidden: Bool {
        get {
            return self.searchButton.isHidden
        }
        set {
            self.searchButton.isHidden = newValue
        }
    }
    
    @IBInspectable
    var isFavouriteBtnHidden: Bool {
        get {
            return self.favouriteButton.isHidden
        }
        set {
            self.favouriteButton.isHidden = newValue
        }
    }
    
    @IBInspectable
    var isCartBtnHidden: Bool {
        get {
            return self.cartButton.isHidden
        }
        set {
            self.cartButton.isHidden = newValue
        }
    }
    //MARK: -Life cycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    //MARK: -Functions
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func injectCoordinator(coordinator : Coordinator){
        self.coordinator = coordinator
    }
    //MARK: -IBAction
    @IBAction func goBack(_ sender: UIButton) {
        coordinator?.popViewController()
    }
    
    @IBAction func navigateToCart(_ sender: UIButton) {
        coordinator?.goToCartPage()
    }
    
    @IBAction func navigateToFavourite(_ sender: UIButton) {
        coordinator?.goToWishListPage(orders: [])
    }
    
    @IBAction func navigateToSearch(_ sender: UIButton) {
        print("SEAAAAAAARCHHHHHH")
    }
}
