//
//  DetailsViewModel.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/27/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import RxSwift

final class DetailsViewModel{
    
    //MARK: vars
    var appCoordinator: AppCoordinator?
    var product : Product?
    var images : Observable<[ProductImage]>
    var sizes : Observable<[String]>
    
      
    init(product : Product){
        self.product = product
        self.images = Observable.of(product.images ?? [])
        self.sizes = Observable.of(product.options?[0].values ?? [])
    }
    
    //MARK: functions
    func goToSignUpScreen() {
        appCoordinator?.goToSignUpPage()
    }
    
}
