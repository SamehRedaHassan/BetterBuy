//
//  OrderItem.swift
//  BetterBuy
//
//  Created by nada elmasry on 6/1/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation

struct OrderItem: Codable {
    internal init(id: Int? = nil, giftCard: Bool? = nil, productExists: Bool? = nil, productID: Int? = nil, quantity: Int? = nil, title: String? = nil, totalDiscount: String? = nil, variantID: Int? = nil , price : String? = nil) {
        self.id = id
        self.giftCard = giftCard
        self.productExists = productExists
        self.productID = productID
        self.quantity = quantity
        self.title = title
        self.totalDiscount = totalDiscount
        self.variantID = variantID
        self.price     = price
    }
    
    var id: Int?
    var giftCard: Bool?
    var productExists: Bool?
    var productID: Int?
    var quantity: Int?
    var title, totalDiscount: String?
    var variantID: Int?
    var price : String?

    enum CodingKeys: String, CodingKey {
        case id
        case price
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
                self.price            = responseData.price
            }
        }
    }
}
