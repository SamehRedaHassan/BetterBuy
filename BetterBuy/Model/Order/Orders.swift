//
//  Orders.swift
//  BetterBuy
//
//  Created by nada elmasry on 6/1/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation

// MARK: - Orders
struct Orders: Codable {
    var orders: [Order]?
    
    init(response : [String : Any]?){
        guard let response = response else {
            print("failed To initialize \(String(describing: self))")
            return
        }
        if let date  = try? JSONSerialization.data(withJSONObject: response, options: []){
            if let responseData = try? JSONDecoder().decode(Orders.self, from: date){
                self.orders = responseData.orders
            }
        }
    }
    
}
