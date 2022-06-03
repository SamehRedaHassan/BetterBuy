//
//  HomeViewModelType.swift
//  BetterBuy
//
//  Created by user222682 on 5/31/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import RxSwift
protocol HomeViewModelType{
    var brandsObservable : Observable<[BrandModel]> {get}
    func getCustomers()
}
