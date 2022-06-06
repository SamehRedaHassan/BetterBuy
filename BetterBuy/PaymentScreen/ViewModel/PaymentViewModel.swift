//
//  PaymentViewModel.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/31/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import RxSwift
final class PaymentViewModel : PaymentViewModelType{
    var bagTotal: BehaviorSubject<Float> = BehaviorSubject<Float>(value: 0.0)
    var bagSubTotal: BehaviorSubject<Float> = BehaviorSubject<Float>(value: 0.0)

    var isValidPromoCode: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    var promoCodeSubject: BehaviorSubject<String> = BehaviorSubject<String>(value: "")
    var isLoading: ActivityIndicator = ActivityIndicator()
    weak var coordinator: Coordinator!
    lazy  var msg = BehaviorSubject<String>(value: "")
    lazy  var Internetmsg = BehaviorSubject<String>(value: "")
    private var coupons : [DiscountCode] = []
    private let disposeBag = DisposeBag()
    private let shipping : Float = 10.0
    private let subToatal : Float
    private let discount: Float = 10
    private var postOrder : PostOrder
    //MARK: Properties
    
    //MARK: Life cycle
    init(coordinator: Coordinator , address : Address , bagSubtotal : Float, order : PostOrder) {
        self.coordinator = coordinator
        self.subToatal = bagSubtotal
        bagSubTotal.onNext(bagSubtotal)
        bagTotal.onNext(bagSubtotal + shipping)
        self.postOrder = order
    }
    
    //MARK: Functions
    func getAllCoupons() {
        getApi(apiRouter: .getAllCoupons)
            .trackActivity(isLoading)
            .observeOn(ConcurrentDispatchQueueScheduler.init(qos: .userInitiated))
            .subscribe {[weak self] (event) in
                guard let self = self else { return }
                switch event {
                case .next(let result):
                    switch result {
                    case .success(value: let response):
                        let apiResponse = GetCouponsResponseModel(response: response)
                        self.coupons = apiResponse.discount_codes ??  []
                        
                    case .internetFailure(let error):
                        self.Internetmsg.onNext(error.message)
                        
                    case .failure(let error):
                        self.msg.onNext(error.message)
                    }
                default:
                    break
                }
            }.disposed(by: disposeBag)
    }
    
    func checkPromoCode() {
        
        if(try! isValidPromoCode.value()){
            isValidPromoCode.onNext(false)
            bagTotal.onNext(subToatal + shipping)

        }else {
            var isValid = false
            let code = try! promoCodeSubject.value()
            for coupon in coupons {
                isValid = coupon.code == code
                break
            }
            isValidPromoCode.onNext(isValid)
            bagTotal.onNext(subToatal + shipping - discount)
        }
    }
    
    func placeOrder() {
     //   let order = PostOrder(
      // let addressObject  = AddAddressPostModel(address: address)
        let result : Observable<GetAddressesResponseModel> = postApi(endPoint: .addOrder(order: postOrder))
            result.subscribe(onNext: { [weak self] (result) in
                guard let self = self else {return}
                
                //MARK: The returned type is not of type customer (No id)
                //print (result.customer?.firstName!)
                print(result.addresses)
                

                
           //     self.successMsgSubject.onNext("Registered Successfully.")
            }, onError: { (error) in
              //  self.errorMsgSubject.onNext("An error occured please try again.")
            }, onCompleted: {
                print("completed")
                }).disposed(by: disposeBag)
    }
    
    
}

