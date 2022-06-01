//
//  ProductsViewModel.swift
//  BetterBuy
//
//  Created by Mohamed Adel on 5/25/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import RxSwift

final class ProductsViewModel : ProductViewModelType{
        
    var appCoordinator:AppCoordinator?
    
    var productsObservable: Observable<[Product]>
    let disposeBag = DisposeBag()
    private var productResponse = BehaviorSubject<[Product]>(value:[])
    
    init() {
        productsObservable = productResponse.asObservable()
    }
    func getProducts() {
        getApi(apiRouter: .getAllProducts)
        //      .trackActivity(isLoading)
              .observeOn(ConcurrentDispatchQueueScheduler.init(qos: .userInitiated))
              .subscribe {[weak self] (event) in
                guard let self = self else {return}
                switch event {
                    case .next(let result):
                        switch result {
                        case .success(let response):
                            let productResponseData = ProductResponse(response: response)
                            print(response)
                            self.productResponse.onNext(productResponseData.products ?? [])
                            print(productResponseData.products?.count ?? 0)
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
    
    
}
