//
//  AddressResponse.swift
//  BetterBuy
//
//  Created by nada elmasry on 6/6/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

// MARK: - Welcome
struct AddressResponse : Codable {
    let customerAddress: CustomerAddress

    enum CodingKeys: String, CodingKey {
        case customerAddress = "customer_address"
    }
}

// MARK: - CustomerAddress
struct CustomerAddress: Codable {
    let id, customerID: Int
    let firstName, lastName: String
    let company: String?
    let address1: String
    let address2: String?
    let city: String
    let province: String?
    let country: String
    let zip, phone: String?
    let name: String
    let provinceCode: String?
    let countryCode, countryName: String
    let customerAddressDefault: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case customerID = "customer_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case company, address1, address2, city, province, country, zip, phone, name
        case provinceCode = "province_code"
        case countryCode = "country_code"
        case countryName = "country_name"
        case customerAddressDefault = "default"
    }
}


