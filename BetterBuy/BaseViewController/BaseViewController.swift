//
//  BaseViewController.swift
//  BetterBuy
//
//  Created by user222682 on 5/25/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    func toogleTabbar(hide: Bool) {
        guard let tabBar = tabBarController as? TabBarContoller else { return }
        tabBar.toggle(hide: hide)
    }
    
    func animateTheHeightOfTheView(height : CGFloat ,view : UIView){
        view.layoutIfNeeded() // force any pending operations to finish

        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            view.constrainHeight(constant: height)
            self.view.layoutIfNeeded()
        })
    }
}

