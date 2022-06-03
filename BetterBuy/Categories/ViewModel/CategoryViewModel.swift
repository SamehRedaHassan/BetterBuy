//
//  CategoryViewModel.swift
//  BetterBuy
//
//  Created by Mohamed Adel on 5/25/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
final class CategoryViewModel : CategoryViewModelType{
    
    weak var coordinator: Coordinator!
    
    
    //MARK: Life cycle
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    func navigateToProducts(category: String, brand: String) {
        coordinator.goToProductsPage(category: category, brand: brand)
    }
}
