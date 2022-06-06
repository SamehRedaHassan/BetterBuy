//
//  AddAddressPostModel.swift
//  BetterBuy
//
//  Created by user222682 on 6/6/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
// MARK: - Welcome
struct AddAddressPostModel : Codable {
  
    var address: Address?
    
    internal init(address: Address? = nil) {
        self.address = address
    }
    
    init(response : [String : Any]?){
        guard let response = response else {
            print("failed To initialize \(String(describing: self))")
            return
        }
        if let date  = try? JSONSerialization.data(withJSONObject: response, options: []){
            if let responseData = try? JSONDecoder().decode(AddAddressPostModel.self, from: date){
                self.address        = responseData.address
            }
        }
    }
}
