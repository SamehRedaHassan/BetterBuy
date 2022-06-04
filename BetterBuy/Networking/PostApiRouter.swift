//
//  PostApiRouter.swift
//  BetterBuy
//
//  Created by nada elmasry on 6/4/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation


enum PostApiRouter {
    case register(customer : PostCustomerResponseModel)
    
    //https://4a798eacca0d39cc2048369ad2025b47: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@mad-sv.myshopify.com/admin/api/2021-04/customers.json
    func getRequest()  -> URLRequest {
        
        //construct the url request
        let body : Data? =  {
            //what goes through the request bodyz
            switch self {
            case .register(let customer):
                do {
//                    let json : [String: Any]? = try?  customer.toDictionary()
//                    let jsonData = try? JSONSerialization.data(withJSONObject: json!)
//                    print(NSString(data: jsonData!, encoding: .zero))
                    
                    return try? JSONEncoder().encode(customer)
                }
            }
            
        }()
        
        //construct the url
        let url : URL = {
            let baseURL : String = {
                return BASE_URL
            }()
            
            let relativeURL : String? = {
                switch self {
                    
                case .register(_):
                    return "2022-04/customers.json"
                }
            }()
            
            let url = URL(string: (baseURL + (relativeURL ?? "")))!
            return url
        }()

        let method : String = {
            switch self {
            case .register( _):
                return "POST"
            }
        }()
    
        var request = URLRequest(url: url)
        
        request.httpMethod = method
        request.httpShouldHandleCookies = false
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        //let customer = Customer(firstName: "sameh", lastName: "redaa", tags: "no tag", email: "mo7.redaaa@gmail.com")
        //let modelCustomer = LoginResponseModel(customer: customer)
        //request.httpBody = try! JSONEncoder().encode(modelCustomer)
        if let httpBody = body {
            request.httpBody = httpBody
            print(NSString(data: httpBody, encoding: .zero)!)
        }
        return request
        
    }
    
}
