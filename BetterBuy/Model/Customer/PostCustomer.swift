//
//  PostCustomer.swift
//  BetterBuy
//
//  Created by nada elmasry on 6/4/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation

struct PostCustomer :Codable{
    internal init(email: String? = nil, firstName: String? = nil, lastName: String? = nil, tags: String? = nil) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.tags = tags
    }
    
    var email: String?
    var firstName, lastName: String?
    var tags: String?
    
    enum CodingKeys: String, CodingKey {
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case tags
    }
}
