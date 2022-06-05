//
//  PaymentViewModel.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/31/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation

final class PaymentViewModel : PaymentViewModelType{
    weak var coordinator: Coordinator!
    
        
    //MARK: Properties
    
    //MARK: Life cycle
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    //MARK: Functions
}
 
