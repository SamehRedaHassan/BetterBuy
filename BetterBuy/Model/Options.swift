//
//  Options.swift
//  BetterBuy
//
//  Created by Mohamed Adel on 6/1/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation


struct ProductOption: Codable {
    var id, productID: Int?
    var name: String?
    var values: [String]?

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case values
    }
    
    init(sizes : [String]){
        self.values = sizes
    }
    
    init(response : [String : Any]?){
        guard let response = response else {
            print("failed To initialize \(String(describing: self))")
            return
        }
        if let date  = try? JSONSerialization.data(withJSONObject: response, options: []){
            if let responseData = try? JSONDecoder().decode(ProductOption.self, from: date){
                self.id        = responseData.id
                self.productID = responseData.productID
                self.name     = responseData.name
                self.values = responseData.values
            }
        }
    }
}
