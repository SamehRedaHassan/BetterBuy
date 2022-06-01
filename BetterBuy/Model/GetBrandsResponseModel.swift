//
//  GetBrandsResponseModel.swift
//  BetterBuy
//
//  Created by user222682 on 5/31/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct GetBrandsResponseModel: Codable {
    var brands: [BrandModel]?
    
    enum CodingKeys: String, CodingKey {
        case brands = "smart_collections"
    }
    init(response : [String : Any]?){
        guard let response = response else {
            print("failed To initialize \(String(describing: self))")
            return
        }
        if let date  = try? JSONSerialization.data(withJSONObject: response, options: []){
            if let responseData = try? JSONDecoder().decode(GetBrandsResponseModel.self, from: date){
                self.brands          = responseData.brands
            }
        }
    }
    
}
