//
//  NavigationController.swift
//  BetterBuy
//
//  Created by nada elmasry on 6/7/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//
import UIKit
extension UINavigationController {

    func containsViewController(ofKind kind: AnyClass) -> Bool {
        return self.viewControllers.contains(where: { $0.isKind(of: kind) })
    }

    func popPushToVC(ofKind kind: AnyClass, pushController: UIViewController, animated : Bool) {
        if containsViewController(ofKind: kind) {
            for controller in self.viewControllers {
                if controller.isKind(of: kind) {
                    popToViewController(controller, animated: animated)
                    break
                }
            }
        } else {
            pushViewController(pushController, animated: animated)
        }
    }
}
