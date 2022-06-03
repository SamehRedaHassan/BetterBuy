//
//  Products.swift
//  BetterBuy
//
//  Created by Mohamed Adel on 6/1/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation

struct ProductResponse: Codable {
    
    var products: [Product]?
    
    init(response : [String : Any]?){
        guard let response = response else {
            print("failed To initialize \(String(describing: self))")
            return
        }
        if let date  = try? JSONSerialization.data(withJSONObject: response, options: []){
            if let responseData = try? JSONDecoder().decode(ProductResponse.self, from: date){
                self.products = responseData.products
            }
        }
    }
    

}
