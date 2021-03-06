//
//  APIRouter.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/30/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//


import Foundation
import Alamofire


let BASE_URL =
"https://95b83bddd1008b211ae15f1779d3ab6e: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@mad42-sv-final.myshopify.com/admin/api/"



enum APIRouter : URLRequestConvertible{ //used to construct url Request
    //all available endpoints
//    case getAllCustomers
    case getAllBrands
    case getAllProducts
    case getCustomerById(id : String)
    case getCustomerOrders(id : String)
    case getAllCustomers
    case getAllAddresses(id : String)
    case getAllCoupons
    


    
    //https://4a798eacca0d39cc2048369ad2025b47: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@mad-sv.myshopify.com/admin/api/2021-04/customers.json
    func asURLRequest() throws -> URLRequest {
        
        //construct the url request
        let params : ([String : Any]?) =  {
            //what goes through the request bodyz
            switch self {
            case .getAllProducts:
                return [:]
            default:
                return [:]
            }
            
        }()
        
        
        //construct the url
        let url : URL = {
            let baseURL : String = {
                return BASE_URL
            }()
            
            let relativeURL : String? = {//endpoint
                switch self {
                case .getAllProducts:
                    return "2022-04/products.json"
                case .getAllBrands:
                    return "2022-04/smart_collections.json"
                case .getCustomerById(id: let id):
                    return "2022-04/customers/\(id).json"
                    
                case .getCustomerOrders(id: let id):
                    return "2022-04/customers/\(id)/orders.json"

                case .getAllCustomers:
                    return "2021-04/customers.json"
                    
                case .getAllAddresses(id: let id):
                    return "2022-04/customers/\(id)/addresses.json"
                
                case .getAllCoupons:
                    return "2022-04/price_rules/1027348594860/discount_codes.json"
                }
            }()
            //safe characters +
            //unsafe characters " "
            //.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
            let url = URL(string: (baseURL + (relativeURL ?? "")))!
            return url
        }()
        
        let encoding : ParameterEncoding = {
            return JSONEncoding.default
        }()
        
        let headers : [String : String]? = {
            let header = ["Content-Type": "application/json",
                          "Accept":"application/json",
                         ] // "lang" : "en"
//            if Application.getToken().count > 0 {
//                header["Authorization"] = "Bearer\(Application.getToken())"
//            }
            return header
        }()
        
        let method : HTTPMethod = {
            switch self {
            case .getAllBrands:
                return HTTPMethod.get
              
            case .getCustomerById(id: _):
                return HTTPMethod.get
              
            case .getCustomerOrders(id: _):
                return HTTPMethod.get
                
            case .getAllCustomers:
                return HTTPMethod.get
              
            default:
                return HTTPMethod.get

            }
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        print(urlRequest)
        switch self {

            
        default :
            return try encoding.encode(urlRequest, with: nil)

        }
    }
    
    
}
