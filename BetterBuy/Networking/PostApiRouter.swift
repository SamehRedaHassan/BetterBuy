//
//  PostApiRouter.swift
//  BetterBuy
//
//  Created by user222682 on 6/2/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import Alamofire
enum PostApiRouter {
    case register(customer : LoginResponseModel)
    
    //https://4a798eacca0d39cc2048369ad2025b47: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@mad-sv.myshopify.com/admin/api/2021-04/customers.json
    func getRequest()  -> URLRequest {
        
        //construct the url request
        let body : Data? =  {
            //what goes through the request bodyz
            switch self {
                
            case .register(let customer):
                do {
                    let json : [String: Any]? = try?  customer.toDictionary()
                    
                    let jsonData = try? JSONSerialization.data(withJSONObject: json!)
                    print(NSString(data: jsonData!, encoding: .zero))

                    return jsonData
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
        
        
        
        
        let method : HTTPMethod = {
            switch self {
                
            case .register( _):
                return .post
            }
        }()
    
        var request = URLRequest(url: url)
       /* request.httpMethod = method.rawValue
        request.httpShouldHandleCookies = false
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let customer = Customer(firstName: "sameh", lastName: "redaa", tags: "no tag", email: "mo7.redaaa@gmail.com")
        let modelCustomer = LoginResponseModel(customer: customer)
        request.httpBody = try! JSONEncoder().encode(modelCustomer)
        if let httpBody = body {
            print(NSString(data: httpBody, encoding: .zero))
        }*/
        return request
        
    }
    
}

extension Encodable {
    
    /// Converting object to postable dictionary
    func toDictionary(_ encoder: JSONEncoder = JSONEncoder()) throws -> [String: Any] {
        let data = try encoder.encode(self)
        let object = try JSONSerialization.jsonObject(with: data)
        guard let json = object as? [String: Any] else {
            let context = DecodingError.Context(codingPath: [], debugDescription: "Deserialized object is not a dictionary")
            throw DecodingError.typeMismatch(type(of: object), context)
        }
        return json
    }
}
