//
//  CurrencyConverter.swift
//  BetterBuy
//
//  Created by nada elmasry on 6/4/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation


func returnPrice(price : Double) -> String {
    if let currency = UserDefaults.standard.string(forKey:  "currency"){
        if(currency == "EG"){
            return "EGP "+"\(price)"
        } else if (currency == "USD") {
            return "$"+"\(String(format: "%.2f", price/18.5))"
            
        }
    } else {
        UserDefaults.standard.set("EG", forKey: "currency")
        return "EGP"+"\(price)"
    }
    return ""
}
    

