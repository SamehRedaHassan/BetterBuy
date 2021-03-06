//
//  HomeViewModel.swift
//  BetterBuy
//
//  Created by user222682 on 5/31/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//
import RxSwift
import Foundation
//import NVActivityIndicatorView
class HomeViewModel : HomeViewModelType{

    //MARK: Properties
    let isLoading: ActivityIndicator =  ActivityIndicator()
    let disposeBag = DisposeBag()
    var brandsObservable : Observable<[BrandModel]>
    var ads : Observable<[String]>
    private var brands : [BrandModel] = []
    lazy private var msg = BehaviorSubject<String>(value: "")
    lazy private var Internetmsg = BehaviorSubject<String>(value: "")
    private var brandsResponse   = BehaviorSubject<[BrandModel]>(value:[])
    private var adsResponse      = BehaviorSubject<[String]>(value:[  "banner1", "banner2", "banner3"])
    weak var coordinator: Coordinator!
    
    //MARK: Life cycle 
    init(coordinator: Coordinator){
        self.coordinator = coordinator
        brandsObservable = brandsResponse.asObservable()
        ads              = adsResponse.asObservable()
    }
 
    
    func navigateToProducts(withBrandAtIndex: IndexPath) {
        coordinator.goToProductsPage(category: "", brand: brands[withBrandAtIndex.item].title ?? "")
    }
    
    func getCustomers() {
        getApi(apiRouter: .getAllBrands)
            .trackActivity(isLoading)
            .observeOn(ConcurrentDispatchQueueScheduler.init(qos: .userInitiated))
            .subscribe {[weak self] (event) in
                guard let self = self else { return }
                switch event {
                case .next(let result):
                    switch result {
                    case .success(value: let response):
                        let apiResponse = GetBrandsResponseModel(response: response)
                        self.brandsResponse.onNext(apiResponse.brands ?? [])
                        self.brands = apiResponse.brands ?? []
                     //   print(apiResponse.brands?.count)
                   
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

}
