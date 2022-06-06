//
//  GetCouponsResponsModel.swift
//  BetterBuy
//
//  Created by user222682 on 6/6/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
class GetCouponsResponseModel : Codable {
    
    var discount_codes : [DiscountCode]?
    
    init(response : [String : Any]?){
        guard let response = response else {
            print("failed To initialize \(String(describing: self))")
            return
        }
        if let date  = try? JSONSerialization.data(withJSONObject: response, options: []){
            if let responseData = try? JSONDecoder().decode(GetCouponsResponseModel.self, from: date){
                self.discount_codes = responseData.discount_codes
            }
        }
    }
    
    
}
