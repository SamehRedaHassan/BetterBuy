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
    
    
    
    var coordinator:Coordinator!
    var category : String!
    var brand : String!
    
    //MARK: - data properties
    var productsObservable: Observable<[Product]>
    var products : [Product]?
    let disposeBag = DisposeBag()
    let favouriteCoreData : LocalDbType
    private var productResponse = BehaviorSubject<[Product]>(value:[])
    
    //MARK: - Initalizer
    init(category : String,brand : String,favouriteCoreData : LocalDbType,coordinator : Coordinator) {
        productsObservable = productResponse.asObservable()
        self.category = category
        self.brand = brand
        self.favouriteCoreData = favouriteCoreData
        self.coordinator = coordinator
    }
    
    //MARK: - functions
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
    func navigateToProducts(index: Int) {
        do {
         products = try productResponse.value()
        coordinator?.goToProductDetailsPage(product: products![index])
        }
        catch {
            print ("error")
        }
    }
    
    private func filterProductByCategory(products : [Product]) -> [Product]{
        return products.filter { (product) -> Bool in
            if(category == "men"){
                category = " " + (category ?? "")
            }
            return (product.tags?.contains("\(category!)"))!
        }
    }
    
   
    
    
    
    
}
