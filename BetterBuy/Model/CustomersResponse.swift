//
//  CustomersResponse.swift
//  BetterBuy
//
//  Created by Mohamed Adel on 6/5/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
struct CustomersResponse:Codable{
    var customers:[Customer]?
    
    init(response : [String : Any]?){
           guard let response = response else {
               print("failed To initialize \(String(describing: self))")
               return
           }
           if let date  = try? JSONSerialization.data(withJSONObject: response, options: []){
               if let responseData = try? JSONDecoder().decode(CustomersResponse.self, from: date){
                   self.customers = responseData.customers
               }
           }
       }
    
}
