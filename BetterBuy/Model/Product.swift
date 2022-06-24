//
//  Product.swift
//  BetterBuy
//
//  Created by Mohamed Adel on 6/1/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation

//enum ProductType: String, Codable {
//    case accessories = "ACCESSORIES"
//    case shoes = "SHOES"
//    case tShirts = "T-SHIRTS"
//}

struct Product: Codable {
    
    var id: Int?
    var title, description, vendor: String?
    var productType: String?
    var tags: String?
    var variants: [Variant]?
    var options: [ProductOption]?
    var images: [ProductImage]?
    var favProduct : Bool = false
    var count = 1
    init(){
        
    }
    
    init(id : Int , title : String , description : String) {
        self.id = id
        self.title = title
        self.description = description
    }
    
    init(response : [String : Any]?){
        guard let response = response else {
            print("failed To initialize \(String(describing: self))")
            return
        }
        if let date  = try? JSONSerialization.data(withJSONObject: response, options: []){
            if let responseData = try? JSONDecoder().decode(Product.self, from: date){
                self.id          = responseData.id
                self.title       = responseData.title
                self.description = responseData.description
                self.vendor      = responseData.vendor
                self.tags        = responseData.tags
                self.productType = responseData.productType
                self.variants    = responseData.variants
                self.options     = responseData.options
                self.images      = responseData.images
            }
        }
    }
    
    enum CodingKeys: String, CodingKey {
        
        case id, title
        case description = "body_html"
        case vendor
        case productType = "product_type"
        case tags
        case variants, options, images
    }
}
