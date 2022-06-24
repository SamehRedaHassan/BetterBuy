//
//  ProductDetailsTest.swift
//  BetterBuyTests
//
//  Created by nada elmasry on 6/24/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import XCTest
@testable import BetterBuy

class ProductDetailsTest: XCTestCase {
    var viewModel : DetailsViewModel?
    
    override func setUp() {
        viewModel = DetailsViewModel(product: Product(id: 222, title: "testProduct", description: "testDesc"), db: DbManager.getInstance(appDelegate: UIApplication.shared.delegate as! AppDelegate), cartDb: CartDBManager.getInstance(appDelegate: UIApplication.shared.delegate as! AppDelegate), coordinator: AppCoordinator(navigationController: UINavigationController()))
    }

    override func tearDown() {
        viewModel = nil
    }

}
