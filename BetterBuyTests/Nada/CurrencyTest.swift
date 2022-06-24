//
//  BetterBuyTests.swift
//  BetterBuyTests
//
//  Created by Mohamed Adel on 5/22/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import XCTest
@testable import BetterBuy

class CurrencyTest: XCTestCase {
        var currency = UserDefaults.standard.string(forKey: "currency")
        

        override func tearDown() {
            UserDefaults.standard.set(currency, forKey: "currency")
        }
    
       func testReturnPriceUSD(){
        //GIVEN
        let price = 20.0
        UserDefaults.standard.set("USD", forKey: "currency")
        //WHEN
        let newPrice = returnPrice(price: price)
        //THEN
        XCTAssertEqual("$1.08" , newPrice)
    }
    
    func testReturnPriceEGP(){
        //GIVEN
        let price = 20.0
        UserDefaults.standard.set("EG", forKey: "currency")
        //WHEN
        let newPrice = returnPrice(price: price)
        //THEN
        XCTAssertEqual("EGP 20.0" , newPrice)
    }
    
    func testReturnPriceFirstTime(){
        //GIVEN
        let price = 20.0
        UserDefaults.standard.set(nil , forKey: "currency")
        //WHEN
        let newPrice = returnPrice(price: price)
        //THEN
        XCTAssertEqual("EGP20.0" , newPrice)
    }
    
}
