//
//  RegisterViewModelType.swift
//  BetterBuy
//
//  Created by nada elmasry on 6/3/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import RxSwift

protocol RegisterViewModelType {
    var passwordSubject : BehaviorSubject<String> {get set}
    var userNameSubject : BehaviorSubject<String> {get set}
    var emailSubject : BehaviorSubject<String> {get set}
    var confirmPasswordSubject : BehaviorSubject<String> {get set}
    var errorMsgSubject : PublishSubject<String?> {get}
    var successMsgSubject : PublishSubject<String> {get}
    var isLoading: ActivityIndicator { get }
    var alreadyExistMsgSubject : PublishSubject<String> {get set}
    func goToLoginScreen()
    func goToHomeScreen()
    func validateInput() -> Bool
    func getAllCustomersData()
}
