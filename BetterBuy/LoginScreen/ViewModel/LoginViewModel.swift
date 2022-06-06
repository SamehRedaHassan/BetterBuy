//
//  LoginViewModel.swift
//  BetterBuy
//
//  Created by Mohamed Adel on 5/29/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import RxSwift

final class LoginViewModel : LoginViewModelType{
    
    //MARK: Properties
    weak var coordinator: Coordinator!
    var customers:[Customer]?
    var disposeBag = DisposeBag()
    let isLoading: ActivityIndicator =  ActivityIndicator()
    var passwordSubject : BehaviorSubject<String> = BehaviorSubject<String>(value: "")
    var emailSubject : BehaviorSubject<String> = BehaviorSubject<String>(value: "")
    var errorMsgSubject : PublishSubject<String?> = PublishSubject<String?>()
    
    //MARK: Life cycle
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    //MARK: Functions
    func navigateToSignup(){
        coordinator.goToSignUpPage()
    }
    
    func goBack() {
        coordinator.popViewController()
    }
    func validateInput() -> Bool {
        let validEmail = try! emailSubject.value().isValidEmail
        guard validEmail else {
            errorMsgSubject.onNext("Please Enter Your email and password")
            return false
        }
        
        
        let validPassword = try! passwordSubject.value().isValidPassword
        guard validPassword else {
            errorMsgSubject.onNext("Please Enter Your Password")
            return false
        }
        
        return true
    }
    func getAllCustomersData() {
        getApi(apiRouter: .getAllCustomers)
            .observeOn(ConcurrentDispatchQueueScheduler.init(qos: .userInitiated))
            .subscribe {[weak self] (event) in
                guard let self = self else {return}
                switch event {
                case .next(let result):
                    switch result {
                    case .success(let response):
                        let customers = CustomersResponse(response: response)
                        self.customers = customers.customers
                    case .failure(let error):
                        print(error.message)
                    case .internetFailure(let error):
                        print(error.message)
                    }
                default:
                    break
                }
                
        }.disposed(by: disposeBag)
        
    }
    func checkUserInput(){
        let email = try! self.emailSubject.value()
        let pwd = try! self.passwordSubject.value()
        //MARK: - Lma el api ttsh7an
        for customer in customers ?? []{
            if email == customer.email && pwd == customer.tags{
                // Create JSON Encoder
                let encoder = JSONEncoder()

                // Encode Note
                let data = try! encoder.encode(customer)

                // Write/Set Data
               
                UserDefaults.standard.set(data, forKey: "user")
                coordinator.goToHomeScreen()
            }
        }
        
    }
    
}
