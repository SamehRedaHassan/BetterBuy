//
//  PageOneViewModel.swift
//  BetterBuy
//
//  Created by user222682 on 6/3/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
class PageOneViewModel : PageOneViewModelType {
    
  
    
    weak var coordinator : Coordinator!

    init(coordinator :Coordinator ){
        self.coordinator = coordinator
    }
    
    func goToHomeScreen() {
        coordinator.goToHomeScreen()
    }
    
}
