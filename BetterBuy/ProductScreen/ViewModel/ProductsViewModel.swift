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
    var productsWithFilter : [Product]?
    var subCategory:String = "All"
    let disposeBag = DisposeBag()
    let favouriteCoreData : LocalDbType
    private var productResponse = BehaviorSubject<[Product]>(value:[])
    lazy var isEmptyCollection : PublishSubject<Bool> = PublishSubject()
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
                                let filtetedProduct = self.filterProductByCategory(products: productResponseData.products ?? [])
                                self.products = filtetedProduct
                                self.productResponse.onNext(filtetedProduct)
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
        if subCategory == "All"{
        coordinator?.goToProductDetailsPage(product: products![index])
        }
        else{
           coordinator?.goToProductDetailsPage(product: productsWithFilter![index])
        }
    }
    
    //MARK:- filter data
    private func filterProductByCategory(products : [Product]) -> [Product]{
        if category == ""{
            return filterProductByBrands(products: products)
        }
        return products.filter { (product) -> Bool in
            if(category == "men"){
                category = " " + (category ?? "")
            }
            
            return (product.tags?.contains("\(category!)"))!
        }
    }
    func filterProductBySubCategory(subCategory:String) {
        if subCategory == "ACCESSORIES"{
            let filteredData = products!.filter { (product) -> Bool in
                return (product.productType == subCategory)
            }
            self.productResponse.onNext(filteredData)
            self.isEmptyCollection.onNext(filteredData.isEmpty)
            self.productsWithFilter = filteredData
            self.subCategory = "ACCESSORIES"
        }
        else if subCategory == "SHOES"
        {
//            self.productResponse.onNext(products!.filter { (product) -> Bool in
//                return (product.productType == subCategory)
//            }
//            )
//            self.isEmptyCollection.onNext(products!.filter { (product) -> Bool in
//            return (product.productType == subCategory)
//            }.isEmpty)
            let filteredData = products!.filter { (product) -> Bool in
                return (product.productType == subCategory)
            }
            self.productResponse.onNext(filteredData)
            self.isEmptyCollection.onNext(filteredData.isEmpty)
            self.productsWithFilter = filteredData
            self.subCategory = "SHOES"
        }
        else if subCategory == "T-SHIRTS"{
//            self.productResponse.onNext(products!.filter { (product) -> Bool in
//                return (product.productType == subCategory)
//            }
//            )
//            self.isEmptyCollection.onNext(products!.filter { (product) -> Bool in
//            return (product.productType == subCategory)
//            }.isEmpty)
            let filteredData = products!.filter { (product) -> Bool in
                return (product.productType == subCategory)
            }
            self.productResponse.onNext(filteredData)
            self.isEmptyCollection.onNext(filteredData.isEmpty)
            self.productsWithFilter = filteredData
            self.subCategory = "T-SHIRTS"
        }
        else{
            self.productResponse.onNext(products!)
            self.isEmptyCollection.onNext(products!.isEmpty)
            self.subCategory = "All"
        }
    }
    private func filterProductByBrands(products:[Product])->[Product] {
        return products.filter { (product) -> Bool in
           
            return (product.vendor == brand)
        }
    }
    
    func addProductToFav(index:Int){
        products?[index].favProduct = true
    }
    func removeProductFromFav(index:Int){
        products?[index].favProduct = false
    }
    
   
    
    
    
    
}
