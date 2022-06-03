//
//  LoginResponseModel.swift
//  BetterBuy
//
//  Created by user222682 on 6/1/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import Foundation

// MARK: - Image
struct LoginResponseModel: Codable {
    var customer: Customer?
    
    enum CodingKeys: String, CodingKey {
        case customer
    }
//
//    init(customer : Customer){
//        self.customer = customer
//    }
//
//
//    init(response : [String : Any]?){
//        guard let response = response else {
//            print("failed To initialize \(String(describing: self))")
//            return
//        }
//        if let date  = try? JSONSerialization.data(withJSONObject: response, options: []){
//            if let responseData = try? JSONDecoder().decode(LoginResponseModel.self, from: date){
//                self.customer          = responseData.customer
//            }
//        }
//    }
}
