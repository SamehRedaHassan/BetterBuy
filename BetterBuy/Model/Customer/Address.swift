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
    var address: String?
    var city, country: String?

    enum CodingKeys: String, CodingKey {
        case id
        case customerID = "customer_id"
        case address, city, country
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
                 self.address     = responseData.address
                 self.city      = responseData.city
                 self.country   = responseData.country
            
             }
         }
     }
}
