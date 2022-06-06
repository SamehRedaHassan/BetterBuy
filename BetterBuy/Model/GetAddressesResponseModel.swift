//
//  GetAddressesResponseModel.swift
//  BetterBuy
//
//  Created by user222682 on 6/5/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
// MARK: - Welcome
struct GetAddressesResponseModel: Codable {
  
    var addresses: [Address]?
    
    internal init(addresses: [Address]? = nil) {
        self.addresses = addresses
    }
    
    init(response : [String : Any]?){
        guard let response = response else {
            print("failed To initialize \(String(describing: self))")
            return
        }
        if let date  = try? JSONSerialization.data(withJSONObject: response, options: []){
            if let responseData = try? JSONDecoder().decode(GetAddressesResponseModel.self, from: date){
                self.addresses        = responseData.addresses
            }
        }
    }
}
