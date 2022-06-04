//
//  OrderListViewModelType.swift
//  BetterBuy
//
//  Created by Mohamed Adel on 6/4/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
protocol OrderlistViewModelType :AnyObject{

    var coordinator: Coordinator?{get}
    var orders : [Product]?{get set}
    func getAllFavourites()
    func deleteProductFromFavourite(product : Product)
}
