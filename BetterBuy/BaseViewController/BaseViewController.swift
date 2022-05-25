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
}

