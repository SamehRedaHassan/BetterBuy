//
//  Address.swift
//  BetterBuy
//
//  Created by nada elmasry on 6/1/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation

// MARK: - Address
struct Address: Codable {

    
    var id, customerID: Int?
    var address1: String?
    var city, country: String?

    enum CodingKeys: String, CodingKey {
        case id
        case customerID = "customer_id"
        case address1, city, country
    }
    
    internal init(id: Int? = nil, customerID: Int? = nil, address1: String? = nil, city: String? = nil, country: String? = nil) {
        self.id = id
        self.customerID = customerID
        self.address1 = address1
        self.city = city
        self.country = country
    }
    
    init(response : [String : Any]?){
         guard let response = response else {
             print("failed To initialize \(String(describing: self))")
             return
         }
         if let date  = try? JSONSerialization.data(withJSONObject: response, options: []){
             if let responseData = try? JSONDecoder().decode(Address.self, from: date){
                 self.id            = responseData.id
                 self.customerID         = responseData.customerID
                 self.address1     = responseData.address1
                 self.city      = responseData.city
                 self.country   = responseData.country
            
             }
         }
     }
}
