//
//  BrandModel.swift
//  BetterBuy
//
//  Created by user222682 on 5/31/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//
import Foundation
// MARK: - BrandModel
struct BrandModel: Codable {
    var id: Int?
    var title: String?
    var image: ImageModel?

    enum CodingKeys: String, CodingKey {
        case id,  title , image

       
    }
    
    init(response : [String : Any]?){
        guard let response = response else {
            print("failed To initialize \(String(describing: self))")
            return
        }
        if let date  = try? JSONSerialization.data(withJSONObject: response, options: []){
            if let responseData = try? JSONDecoder().decode(BrandModel.self, from: date){
                self.id          = responseData.id
                self.title          = responseData.title
                self.image          = responseData.image

            }
        }
    }

}
