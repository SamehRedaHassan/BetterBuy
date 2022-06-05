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
    var successMsgSubject : PublishSubject<String> = PublishSubject<String>()
    var successMsgObservable : Observable<String>
    var alreadyExistMsgSubject : PublishSubject<String> = PublishSubject<String>()
    var customers : [Customer]?
    
    init(coordinator: Coordinator){
        self.coordinator = coordinator
        successMsgObservable = successMsgSubject.asObservable()
    }
    
    //MARK: functions
    func goToLoginScreen() {
        coordinator.popViewController()
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
    
        let customer = PostCustomer(email: try! emailSubject.value().lowercased(), firstName: try! userNameSubject.value(), lastName: "", tags: try! passwordSubject.value())
                    let modelCustomer = PostCustomerResponseModel(customer: customer)
                    let result : Observable<PostCustomerResponseModel> = postApi(endPoint: .register(customer: modelCustomer))
            result.subscribe(onNext: { [weak self] (result) in
                guard let self = self else {return}
                
                //MARK: The returned type is not of type customer (No id)
                //UserDefaults.saveUserObject(user: result.customer)
                
                
                self.successMsgSubject.onNext("Registered Successfully.")
            }, onError: { (error) in
                self.errorMsgSubject.onNext("An error occured please try again.")
            }, onCompleted: {
                print("completed")
                }).disposed(by: disposeBag)
        
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
                        self.customers = customers.customers ?? []
                        if(!(self.checkifUserExistBefore())){
                            self.registerUser()
                        } else {
                            self.errorMsgSubject.onNext("This email already exist please provide a new one or login instead")
                        }
                        
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
    
    func checkifUserExistBefore() -> Bool{
        let email = try! self.emailSubject.value().lowercased()
        for customer in customers ?? []{
            if email == customer.email {
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    func goToHomeScreen(){
        coordinator.goToHomeScreen()
    }
    
    
    
}


