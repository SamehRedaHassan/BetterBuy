//
//  Order.swift
//  BetterBuy
//
//  Created by nada elmasry on 6/1/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation

struct Order: Codable {
    var id: Int?
    var customer: Customer?
    var orderItems: [OrderItem]?
    var cancelReason: String?
    var currentTotalPrice: String?

    var discountCodes: [DiscountCode]?
    var financialStatus: OrderFinancialStatus?
    var fulfillmentStatus: String?
    var totalDiscounts: String?
    var totalPrice: String?
    

    enum CodingKeys: String, CodingKey {
        case id
        case customer
        case orderItems = "line_items"
        case cancelReason = "cancel_reason"
        case currentTotalPrice = "current_total_price"
        case discountCodes = "discount_codes"
        case financialStatus = "financial_status"
        case fulfillmentStatus = "fulfillment_status"
        case totalDiscounts = "total_discounts"
        case totalPrice = "total_price"
    }
    
    init(customer: Customer, orderItems: [OrderItem]) {
        self.customer = customer
        self.orderItems = orderItems
    }
    
    init(response : [String : Any]?){
        guard let response = response else {
            print("failed To initialize \(String(describing: self))")
            return
        }
        if let date  = try? JSONSerialization.data(withJSONObject: response, options: []){
            if let responseData = try? JSONDecoder().decode(Order.self, from: date){
                self.id               = responseData.id
                self.customer         = responseData.customer
                self.orderItems         = responseData.orderItems
                self.cancelReason        = responseData.cancelReason
                self.currentTotalPrice         = responseData.currentTotalPrice
                self.discountCodes            = responseData.discountCodes
                self.financialStatus    = responseData.financialStatus
                self.fulfillmentStatus       = responseData.fulfillmentStatus
                self.totalDiscounts        = responseData.totalDiscounts
                self.totalPrice        = responseData.totalPrice
                
            }
        }
    }
}
