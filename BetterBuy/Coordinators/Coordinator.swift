//
//  Coordinator.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/24/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator : AnyObject{
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController : UINavigationController { get set }
    func start()
    
    func navigateToHomeOrIntro()
    func goToHomeScreen()
    func goToSignUpPage()
    func goToProfilePage()
    func goToWishListPage(orders : [Order])
    func goToProfileOrderListPage()
    func goToProductDetailsPage(product: Product)
    func goToLoginPage()
    func goToProductsPage(category:String,brand:String)
    func popViewController()
    func goToCartPage()
}
