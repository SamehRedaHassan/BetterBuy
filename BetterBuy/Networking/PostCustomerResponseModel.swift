//
//  PostCustomerResponseModel.swift
//  BetterBuy
//
//  Created by nada elmasry on 6/4/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation

struct PostCustomerResponseModel: Codable {
    var customer: PostCustomer?

    enum CodingKeys: String, CodingKey {
        case customer
    }
}
