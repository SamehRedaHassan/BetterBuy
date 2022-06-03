//
//  Customer.swift
//  BetterBuy
//
//  Created by nada elmasry on 6/1/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation

// MARK: - Customer
struct Customer: Codable {
    var id: Int?
    var email: String?
    var firstName, lastName: String?
    var ordersCount: Int?
    var totalSpent: String?
    var verifiedEmail: Bool?
    var phone: String?
    var tags: String?
    var addresses: [Address]?

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case ordersCount = "orders_count"
        case totalSpent = "total_spent"
        case verifiedEmail = "verified_email"
        case phone, tags
        case addresses
    }
    
    init(response : [String : Any]?){
        guard let response = response else {
            print("failed To initialize \(String(describing: self))")
            return
        }
        if let date  = try? JSONSerialization.data(withJSONObject: response, options: []){
            if let responseData = try? JSONDecoder().decode(Customer.self, from: date){
                self.id            = responseData.id
                self.email         = responseData.email
                self.firstName     = responseData.firstName
                self.lastName      = responseData.lastName
                self.ordersCount   = responseData.ordersCount
                self.totalSpent    = responseData.totalSpent
                self.verifiedEmail = responseData.verifiedEmail
                self.tags          = responseData.tags
                self.phone         = responseData.phone
                self.addresses     = responseData.addresses
            }
        }
    }
}
