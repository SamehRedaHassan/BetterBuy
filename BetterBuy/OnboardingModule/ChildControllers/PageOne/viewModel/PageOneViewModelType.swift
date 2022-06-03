//
//  PageOneViewModelType.swift
//  BetterBuy
//
//  Created by user222682 on 6/3/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
protocol PageOneViewModelType : AnyObject{
    var coordinator : Coordinator! {get set}
    func goToHomeScreen()
}
