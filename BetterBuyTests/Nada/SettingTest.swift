//
//  SettingTest.swift
//  BetterBuyTests
//
//  Created by nada elmasry on 6/24/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import XCTest
@testable import BetterBuy

class SettingTest: XCTestCase {

    var viewModel : SettingViewModel?
    var user = UserDefaults.standard.string(forKey: "user")
        
        override func setUp() {
            
            viewModel = SettingViewModel(coordinator: AppCoordinator(navigationController: UINavigationController()), cartDB: CartDBManager.getInstance(appDelegate: UIApplication.shared.delegate as! AppDelegate))
        }

        override func tearDown() {
            viewModel = nil
            UserDefaults.standard.set(user, forKey: "user")
        }
    
        func test(){
            viewModel?.logOutUser()
            XCTAssertNil(UserDefaults.standard.string(forKey: "user"))
        }

    }
