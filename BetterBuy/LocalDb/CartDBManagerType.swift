//
//  CartDBManagerType.swift
//  BetterBuy
//
//  Created by Mohamed Adel on 6/4/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
protocol CartDBManagerType {
    func getAllProductsInCart() -> [Product]
    func isInCart(id: String) -> Bool
    func addToCart(product: Product)
    func removeProduct(product : Product)
    func getProductWithId(id: String) -> [Cart]
    func plusCountByOne(id: String)
    func minusCountByOne(id: String)
}
