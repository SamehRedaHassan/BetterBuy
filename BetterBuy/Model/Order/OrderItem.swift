//
//  OrderItem.swift
//  BetterBuy
//
//  Created by nada elmasry on 6/1/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation

struct OrderItem: Codable {
    var id: Int?
    var giftCard: Bool?
    var productExists: Bool?
    var productID: Int?
    var quantity: Int?
    var title, totalDiscount: String?
    var variantID: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case giftCard = "gift_card"
        case productExists = "product_exists"
        case productID = "product_id"
        case quantity
        case title
        case totalDiscount = "total_discount"
        case variantID = "variant_id"
    }
    
    init(response : [String : Any]?){
        guard let response = response else {
            print("failed To initialize \(String(describing: self))")
            return
        }
        if let date  = try? JSONSerialization.data(withJSONObject: response, options: []){
            if let responseData = try? JSONDecoder().decode(OrderItem.self, from: date){
                self.id               = responseData.id
                self.giftCard         = responseData.giftCard
                self.productID        = responseData.productID
                self.quantity         = responseData.quantity
                self.title            = responseData.title
                self.totalDiscount    = responseData.totalDiscount
                self.variantID        = responseData.variantID
            }
        }
    }
}
