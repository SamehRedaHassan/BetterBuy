//
//  RegisterViewModelTest.swift
//  BetterBuyTests
//
//  Created by nada elmasry on 6/24/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import XCTest
@testable import BetterBuy

class RegisterViewModelTest: XCTestCase {

    var viewModel : RegisterViewModelMoc?
    var vm = RegisterViewModel(coordinator: AppCoordinator(navigationController: UINavigationController()))
    
    override func setUp() {
        viewModel = RegisterViewModelMoc()
    }

    override func tearDown() {
        viewModel = nil
    }

    func testGetAllCustomerData() {
        vm.getAllCustomersData()
        viewModel?.getAllCustomersData()
        XCTAssertTrue(((viewModel?.resultReturned) != nil))
    }
    
    func testGoToHomeScreen() {
        viewModel?.goToHomeScreen()
        XCTAssertTrue(((viewModel?.navigatedToHomeScreen) != nil))
    }
    
    func testRegisterUser() {
        vm.registerUser()
        XCTAssertTrue(((viewModel?.navigatedToHomeScreen) != nil))
    }
    
    func testValidateInput() {
        
        XCTAssertNotNil((vm.validateInput()))
    }
    
}
