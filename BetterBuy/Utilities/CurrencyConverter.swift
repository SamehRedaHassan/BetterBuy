//
//  CurrencyConverter.swift
//  BetterBuy
//
//  Created by nada elmasry on 6/4/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation


func returnPrice(price : Double) -> Double {
    if let currency = UserDefaults.standard.string(forKey:  "currency"){
        if(currency == "EG"){
            return (price / 18.5)
        } else if (currency == "USD") {
            return (price * 18.5)
        }
    } else {
        return 0.0
    }
    return 0.0
}
    

