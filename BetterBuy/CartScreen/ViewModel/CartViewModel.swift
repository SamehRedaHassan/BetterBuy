//
//  CartViewModel.swift
//  BetterBuy
//
//  Created by Mohamed Adel on 5/29/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
class CartViewModel : CartViewModelType{

    //MARK: Properties
    weak var coordinator: Coordinator!
    
    //MARK: Life cycle
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    //MARK: Functions
    func goBack() {
        coordinator.popViewController()
    }
    
    func proceedToCheckout() {
        coordinator.proceedToCheckout(withSubtotal: 875.0)
    }
    
}
