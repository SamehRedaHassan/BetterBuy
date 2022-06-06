//
//  SettingsViewModelType.swift
//  BetterBuy
//
//  Created by nada elmasry on 6/4/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import RxSwift

protocol SettingsViewModelType {
    var coordinator: Coordinator { get }
    func goToLocationScreen()
    func logOutUser()
}
