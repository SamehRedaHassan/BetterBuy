//
//  DiscountCode.swift
//  BetterBuy
//
//  Created by nada elmasry on 6/1/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation

struct DiscountCode: Codable {
    var id, priceRuleID: Int?
    var code: String?
    var usageCount: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case priceRuleID = "price_rule_id"
        case code
        case usageCount = "usage_count"
    }
    
    init(response : [String : Any]?){
        guard let response = response else {
            print("failed To initialize \(String(describing: self))")
            return
        }
        if let date  = try? JSONSerialization.data(withJSONObject: response, options: []){
            if let responseData = try? JSONDecoder().decode(DiscountCode.self, from: date){
                self.id            = responseData.id
                self.priceRuleID   = responseData.priceRuleID
                self.code          = responseData.code
                self.usageCount    = responseData.usageCount
            }
        }
    }
}

