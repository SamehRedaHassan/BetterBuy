//
//  LoginViewModelType.swift
//  BetterBuy
//
//  Created by user222682 on 6/4/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import RxSwift
protocol LoginViewModelType : AnyObject {
    var coordinator:Coordinator! {get}
    func navigateToSignup()
    func goBack()
    
    var passwordSubject : BehaviorSubject<String> {get set}
    var emailSubject : BehaviorSubject<String> {get set}
    var errorMsgSubject : PublishSubject<String?> {get}
    var isLoading: ActivityIndicator { get }
    func validateInput() -> Bool
    func getAllCustomersData()
    func checkUserInput()
}
