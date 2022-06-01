//
//  Variants.swift
//  BetterBuy
//
//  Created by Mohamed Adel on 6/1/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
struct Variant: Codable {
    var id : Int?
    var productID : Int?
    var price: String?
    var productSize: String?
    var productColor: String?
    var inventoryQuantity: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case price
        case productSize, productColor
        case inventoryQuantity = "inventory_quantity"
    }
    init(response : [String : Any]?){
        guard let response = response else {
            print("failed To initialize \(String(describing: self))")
            return
        }
        if let date  = try? JSONSerialization.data(withJSONObject: response, options: []){
            if let responseData = try? JSONDecoder().decode(Variant.self, from: date){
                self.id        = responseData.id
                self.productID = responseData.productID
                self.price     = responseData.price
                self.productSize = responseData.productSize
                self.productColor = responseData.productColor
                self.inventoryQuantity = responseData.inventoryQuantity
                
            }
        }
    }
}
