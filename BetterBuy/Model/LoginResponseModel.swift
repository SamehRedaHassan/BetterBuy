//
//  LoginResponseModel.swift
//  BetterBuy
//
//  Created by nada elmasry on 6/4/22.
//

import Foundation

struct LoginResponseModel: Codable {
    var customer: Customer?

    enum CodingKeys: String, CodingKey {
        case customer
    }
}
