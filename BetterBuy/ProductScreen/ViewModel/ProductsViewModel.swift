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
    func goToProductDetailsScreen(product: Int) {
         do {products = try productResponse.value()
           appCoordinator?.goToProductDetailsPage(product: products![product])
           }
           catch {
               print ("error")
           }
                   
    }
    
    var appCoordinator:AppCoordinator?
    var products : [Product]?
    var category : String?
    var productsObservable: Observable<[Product]>
    var imagesHeight : Observable<[Int]>?
    let disposeBag = DisposeBag()
    let favouriteCoreData : LocalDbType
    private var productResponse = BehaviorSubject<[Product]>(value:[])
    
    init(category : String,favouriteCoreData : LocalDbType) {
        productsObservable = productResponse.asObservable()
        self.category = category
        self.favouriteCoreData = favouriteCoreData
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
                            self.productResponse.onNext(self.filterProductByCategory(products: productResponseData.products ?? []))
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
    private func filterProductByCategory(products : [Product]) -> [Product]{
        print(category!)
        return products.filter { (product) -> Bool in
            if(category == "men"){
                category = " " + (category ?? "")
            }
            return (product.tags?.contains("\(category!)"))!
        }
    }
    
   
    
    
    
    
}
