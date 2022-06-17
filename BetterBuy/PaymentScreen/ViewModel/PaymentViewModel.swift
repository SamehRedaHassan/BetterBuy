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
    var bagTotal: BehaviorSubject<Double> = BehaviorSubject<Double>(value: 0.0)
    var bagSubTotal: BehaviorSubject<Double> = BehaviorSubject<Double>(value: 0.0)
    
    var isValidPromoCode: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    var promoCodeSubject: BehaviorSubject<String> = BehaviorSubject<String>(value: "")
    var isLoading: ActivityIndicator = ActivityIndicator()
    weak var coordinator: Coordinator!
    lazy  var msg = BehaviorSubject<String>(value: "")
    lazy  var Internetmsg = BehaviorSubject<String>(value: "")
    private var coupons : [DiscountCode] = []
    private let disposeBag = DisposeBag()
    private let shipping : Double = 10.0
    private let subToatal : Double
    private let discount: Double = 10
    private var postOrder : PostOrder
    var deliveryAdddress : Address
    private var validCoupon : DiscountCode?
    //MARK: Properties
    
    //MARK: Life cycle
    init(coordinator: Coordinator , address : Address , bagSubtotal : Double, order : PostOrder) {
        self.coordinator = coordinator
        self.subToatal = bagSubtotal
        bagSubTotal.onNext(bagSubtotal)
        bagTotal.onNext(bagSubtotal + shipping)
        self.deliveryAdddress = address
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
                validCoupon = coupon
                break
            }
            isValidPromoCode.onNext(isValid)
            bagTotal.onNext(subToatal + shipping - discount)
        }
    }
    
    func placeOrder() {
        //   let order = PostOrder(
        // let addressObject  = AddAddressPostModel(address: address)
        postOrder.order?.default_address = deliveryAdddress
        let bagTotalPrice = try! bagTotal.value()
        postOrder.order?.total_line_items_price = "\(bagTotalPrice)"
        if let validCoupon = validCoupon{
            postOrder.order?.discountCode = [validCoupon]
        }
        let result : Observable<AddOrderResponse> = postApi(endPoint: .addOrder(order: postOrder))
        result.subscribe(onNext: { [weak self] (result) in
            guard let self = self else {return}
            if result.order != nil {
                self.msg.onNext("Order Placed Successfully")
                //
                NotificationCenter.default.post(name: Notification.Name("Order Placed Successfully"), object: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {[weak self] in
                    guard let self = self else {return}
                    self.coordinator.goToHomeScreen()
                }
                //clear cart
            }else {
                self.Internetmsg.onNext("Some thing went wrong")
            }
            
            }, onError: { (error) in
                print(error)
                self.Internetmsg.onNext("Some thing went wrong")
        }, onCompleted: {
            print("completed")
        }).disposed(by: disposeBag)
    }
    
    
}

