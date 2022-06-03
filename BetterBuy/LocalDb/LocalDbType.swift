//
//  LocalDbType.swift
//  BetterBuy
//
//  Created by nada elmasry on 6/2/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation

protocol LocalDbType {
    
    func getAllFavourites() -> [Product]
    func isInFavorites(id: String) -> Bool
    func addFavProduct(product : Product)
    func removeFavProduct(product : Product)
    func getFavItemFromDbWithId(id: String) -> [Favourite]
}
