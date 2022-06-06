//
//  SearchViewModel.swift
//  BetterBuy
//
//  Created by user222682 on 6/5/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//
import RxSwift
import Foundation
class SearchViewModel : SearchViewModelType {
    
    //MARK: Properties
    weak var coordinator: Coordinator!
    var productsObservable: Observable<[Product]>
    private var productsResponse = BehaviorSubject<[Product]>(value:[])
    private var disposeBag = DisposeBag()
    let isLoading: ActivityIndicator =  ActivityIndicator()
    private var products  : [Product] = []
    lazy var filterWordSubject : PublishSubject<String> = PublishSubject()
    lazy var isEmptyCollection : PublishSubject<Bool> = PublishSubject()

    //MARK: Life cycle
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        productsObservable = productsResponse.asObservable()
        filterWordSubject.subscribe {[weak self] searchWord in
            guard let self = self else {return}
            let filteredProducts =  self.products.filter{$0.title!.uppercased().hasPrefix(searchWord.element?.uppercased() ?? "")}
            self.productsResponse.onNext(filteredProducts)
            self.isEmptyCollection.onNext(filteredProducts.isEmpty)
        }.disposed(by: disposeBag)
    }
    
    //MARK: Functions
    func getAllProducts() {
        getApi(apiRouter: .getAllProducts)
            .trackActivity(isLoading)
            .observeOn(ConcurrentDispatchQueueScheduler.init(qos: .userInitiated))
            .subscribe {[weak self] (event) in
                guard let self = self else {return}
                switch event {
                case .next(let result):
                    switch result {
                    case .success(let response):
                        let productResponseData = ProductResponse(response: response)
                        self.products = productResponseData.products ?? []
                        self.productsResponse.onNext(productResponseData.products ?? [])
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
    
    func navigateToProductDetails(atIndex: Int) {
        coordinator.goToProductDetailsPage(product: try! productsResponse.value()[atIndex])
    }
    
}
