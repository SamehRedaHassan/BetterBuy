//
//  RegisterViewModelMoc.swift
//  BetterBuyTests
//
//  Created by nada elmasry on 6/24/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
@testable import BetterBuy
import RxSwift

class RegisterViewModelMoc: RegisterViewModelType {
    
    var passwordSubject: BehaviorSubject<String> = BehaviorSubject<String>(value: "password")
    
    var userNameSubject: BehaviorSubject<String> = BehaviorSubject<String>(value: "username")
    
    var emailSubject: BehaviorSubject<String> = BehaviorSubject<String>(value: "email@gmail.com")
    
    var confirmPasswordSubject: BehaviorSubject<String> = BehaviorSubject<String>(value: "password")
    
    var errorMsgSubject: PublishSubject<String?> = PublishSubject<String?>()
     
    var successMsgSubject: PublishSubject<String> = PublishSubject<String>()
    
    var isLoading: ActivityIndicator = ActivityIndicator()
    
    var alreadyExistMsgSubject: PublishSubject<String> = PublishSubject<String>()
    
    var navigatedToLoginScreen : Bool = false
    var navigatedToHomeScreen : Bool = false
    var resultReturned : Bool = false
    
    func goToLoginScreen() {
        navigatedToLoginScreen = true
    }
    
    func goToHomeScreen() {
        navigatedToHomeScreen = true
    }
    
    func validateInput() -> Bool {
        userNameSubject.on(.next("username"))
        passwordSubject.on(.next("password"))
        confirmPasswordSubject.on(.next("password"))
        emailSubject.on(.next("email@gmail.com"))
        return true
    }
    
    func getAllCustomersData() {
        let result = getApi(apiRouter: .getAllProducts)
        if(result != nil){
        resultReturned = true
        }
    
    }
}
