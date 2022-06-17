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
    case addAddress(address : AddAddressPostModel)
    case addOrder(order : PostOrder)
    //https://4a798eacca0d39cc2048369ad2025b47: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@mad-sv.myshopify.com/admin/api/2021-04/customers.json
    func getRequest()  -> URLRequest {
        
        //construct the url request
        let body : Data? =  {
            //what goes through the request body
            switch self {
            case .register(let customer):
                do {
                    return try? JSONEncoder().encode(customer)
                }
            case .addAddress(address: let address):
                do {
                    return try? JSONEncoder().encode(address)
                }
            case .addOrder(order: let order):
                do {
                    return try? JSONEncoder().encode(order)
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
                    
                case .addAddress(address: _):
                    return "2022-04/customers/\(UserDefaults.getUserObject()!.id!)/addresses.json"
                    
                case .addOrder(order: _):
                    return "2022-04/orders.json"
                    
                }
            }()
            
            let url = URL(string: (baseURL + (relativeURL ?? "")))!
            return url
        }()

        let method : String = {
            switch self {
            case .register( _):
                return "POST"
                
            case .addAddress(address: _):
                return "POST"
                
            case .addOrder(order: let order):
                return "POST"
            }
        }()
    
        var request = URLRequest(url: url)
        
        request.httpMethod = method
        request.httpShouldHandleCookies = false
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        if let httpBody = body {
            request.httpBody = httpBody
            print(NSString(data: httpBody, encoding: .zero)!)
        }
        print(request.url)
        return request
        
    }
    
}
