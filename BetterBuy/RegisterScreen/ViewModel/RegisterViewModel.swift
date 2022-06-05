//
//  SignInViewModel.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/25/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import RxSwift

class RegisterViewModel : RegisterViewModelType {
    
    //MARK: vars
    var coordinator: Coordinator
    var disposeBag = DisposeBag()
    let isLoading: ActivityIndicator =  ActivityIndicator()
    var passwordSubject : BehaviorSubject<String> = BehaviorSubject<String>(value: "")
    var userNameSubject : BehaviorSubject<String> = BehaviorSubject<String>(value: "")
    var emailSubject : BehaviorSubject<String> = BehaviorSubject<String>(value: "")
    var confirmPasswordSubject : BehaviorSubject<String> = BehaviorSubject<String>(value: "")
    var errorMsgSubject : PublishSubject<String?> = PublishSubject<String?>()
    
    init(coordinator: Coordinator){
        self.coordinator = coordinator
    }
    
    //MARK: functions
    func goToLoginScreen() {
        coordinator.popViewController()
    }
    
    func signUpUser(){
        
    }
    
    func validateInput() -> Bool {
        let validUserName = try! userNameSubject.value().isValidUserName
        guard validUserName else{
            errorMsgSubject.onNext("Please provide a valid username")
            return false
        }
        let validEmail = try! emailSubject.value().isValidEmail
        guard validEmail else {
            errorMsgSubject.onNext("Please provide a valid email")
            return false
        }
        let validPassword = try! passwordSubject.value().isValidPassword
        guard validPassword else {
            errorMsgSubject.onNext("Please provide password with eight charachters")
            return false
        }
        
        let validConfirmPassword = try! confirmPasswordSubject.value() == passwordSubject.value()
        guard validConfirmPassword else {
            errorMsgSubject.onNext("Please Re-write thepassword correctly")
            return false
        }
        return true
    }
    
    func registerUser(){
        let customer = PostCustomer(email: try! emailSubject.value(), firstName: try! userNameSubject.value(), lastName: "", tags: try! passwordSubject.value())
                let modelCustomer = PostCustomerResponseModel(customer: customer)
                let result : Observable<PostCustomerResponseModel> = postApi(endPoint: .register(customer: modelCustomer))
        result.subscribe(onNext: { (result) in
            print(result)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("completed")
            }).disposed(by: disposeBag)
    }
    
}


