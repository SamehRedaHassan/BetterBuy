//
//  CategoryViewModel.swift
//  BetterBuy
//
//  Created by Mohamed Adel on 5/25/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
final class CategoryViewModel{
    var appCoordinator: AppCoordinator?
    
    func goToProductsScreen()
    {
        appCoordinator?.goToProductsPage()
    }
}
