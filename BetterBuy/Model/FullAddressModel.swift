//
//  FullAddressModel.swift
//  BetterBuy
//
//  Created by user222682 on 6/5/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//
/*
import Foundation
// MARK: - Address
struct FullAddressModel: Codable {
    var id, customerID: Int?
    var firstName: String?
    var lastName, company: String?
    var address1: String?
    var address2: String?
    var city: String?
    var province: String?
    var country: String?
    var zip: String?
    var phone, name: String?
    var provinceCode: String?
    var countryCode, countryName: String?
    var addressDefault: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case customerID = "customer_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case company, address1, address2, city, province, country, zip, phone, name
        case provinceCode = "province_code"
        case countryCode = "country_code"
        case countryName = "country_name"
        case addressDefault = "default"
    }
    init(response : [String : Any]?){
        guard let response = response else {
            print("failed To initialize \(String(describing: self))")
            return
        }
        if let date  = try? JSONSerialization.data(withJSONObject: response, options: []){
            if let responseData = try? JSONDecoder().decode(FullAddressModel.self, from: date){
                self.id          = responseData.id
                self.customerID          = responseData.customerID
                self.firstName          = responseData.firstName
                self.lastName          = responseData.lastName
                self.company          = responseData.company
                self.address1          = responseData.address1
                self.address2          = responseData.address2
                self.province          = responseData.province
                self.country          = responseData.country
                self.zip          = responseData.zip
                self.phone          = responseData.phone
                self.name          = responseData.name
                self.provinceCode          = responseData.provinceCode
                self.countryCode          = responseData.countryCode
                self.countryName          = responseData.countryName
                self.addressDefault          = responseData.addressDefault
                self.city          = responseData.city

            }
        }
    }
    
}
*/
