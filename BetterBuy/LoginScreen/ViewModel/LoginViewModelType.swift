//
//  LoginViewModelType.swift
//  BetterBuy
//
//  Created by user222682 on 6/4/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
protocol LoginViewModelType : AnyObject {
    var coordinator:Coordinator! {get}
    func navigateToSignup()
    func goBack()
}
