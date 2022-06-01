//
//  OrderFinancialStatus.swift
//  BetterBuy
//
//  Created by nada elmasry on 6/1/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation

enum OrderFinancialStatus: String, Codable {
    case pending = "pending"
    case authorized = "authorized"
    case partiallyPaid = "partially_paid"
    case paid = "paid"
    case partiallyRefunded = "partially_refunded"
    case refunded = "refunded"
    case voided = "voided"
}
