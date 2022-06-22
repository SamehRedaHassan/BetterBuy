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
        print(response)
        if let data  = try? JSONSerialization.data(withJSONObject: response, options: []){
            
            if let responseData = try? JSONDecoder().decode(Orders.self, from: data){
                self.orders = responseData.orders
            }
            
        }
    }
    
}
