//
//  TabbarViewModel.swift
//  BetterBuy
//
//  Created by user222682 on 6/3/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
final class TabbarViewModel : TabbarViewModelType{
    //MARK: Properties
    weak var coordinator: Coordinator!
    
    //MARK: Life cycle
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    //MARK: Functions
}

