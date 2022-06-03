//
//  Customer.swift
//  BetterBuy
//
//  Created by user222682 on 6/1/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
struct Customer : Codable {
    var email: String?
    var firstName : String?
    var lastName : String?
    var tags      : String?
    
    enum CodingKeys: String, CodingKey {
        case email  ,tags
        case firstName = "first_name"
        case lastName  = "last_name"
    }
//    init(firstName : String , lastName : String ,tags : String , email : String){
//        self.email            = email
//        self.tags          = tags
//        self.firstName          = firstName
//        self.lastName          = lastName
//    }
//    init(response : [String : Any]?){
//        guard let response = response else {
//            print("failed To initialize \(String(describing: self))")
//            return
//        }
//        if let date  = try? JSONSerialization.data(withJSONObject: response, options: []){
//            if let responseData = try? JSONDecoder().decode(Customer.self, from: date){
//                self.email            = responseData.email
//                self.tags          = responseData.tags
//                self.firstName          = responseData.firstName
//                self.lastName          = responseData.lastName
//
//
//            }
//        }
//    }

}




