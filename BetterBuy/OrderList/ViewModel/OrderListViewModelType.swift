//
//  OrderListViewModelType.swift
//  BetterBuy
//
//  Created by Mohamed Adel on 6/4/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import RxSwift

protocol OrderlistViewModelType :AnyObject{

    var coordinator: Coordinator?{get}
    var orders : [Product]?{get set}
    //var isEmptyCollection : PublishSubject<Bool> { get set }
    func getAllFavourites()
    func deleteProductFromFavourite(product : Product)
    var isEmptyCollection : BehaviorSubject<Bool> {get}
    func isFavouriteEmpty() -> Bool
}
