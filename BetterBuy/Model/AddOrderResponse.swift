//
//  AddOrderResponse.swift
//  BetterBuy
//
//  Created by nada elmasry on 6/7/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

//  Order.swift
//  InStore
//
//  Created by sandra on 6/3/22.
//  Copyright ©️ 2022 mac. All rights reserved.
//

import Foundation

struct AddOrderResponse: Codable {
    var order: PostNewOrder?
}

// MARK: - discount_codeOrder
//struct PostOrder: Codable {
//    var email, fulfillmentStatus: String?
//    var lineItems: [PostLineItem]?
//    enum CodingKeys: String, CodingKey {
//        case email
//        case fulfillmentStatus = "fulfillment_status"
//        case lineItems = "line_items"
//    }
//}
// new
struct PostNewOrder:Codable {
    var lineItems: [PostLineItem]?
    var customer: MyCustomer?
    var financialStatus: String?
    var discountCode: [DiscountCode]?
    var default_address : Address?
    var total_discounts : String? //
    var total_line_items_price : String? //
    
    enum CodingKeys: String, CodingKey {
        case lineItems = "line_items"
        case customer
        case financialStatus = "financial_status"
        case discountCode = "discount_codes"
    }
}

struct MyCustomer: Codable {
    var id: Int?
}



// MARK: - discount_codeLineItem
struct PostLineItem: Codable {
    var variantID, quantity: Int?
    
    enum CodingKeys: String, CodingKey {
        case variantID = "variant_id"
        case quantity
    }
}
