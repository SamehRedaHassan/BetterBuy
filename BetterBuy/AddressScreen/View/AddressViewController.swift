//
//  AddressViewController.swift
//  BetterBuy
//
//  Created by nada elmasry on 6/4/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit

class AddressViewController: UIViewController {

    //MARK: properties
    var addressViewModel: AddressViewModelType?
    
    
    //MARK: Outlets
    @IBOutlet private weak var countryTxtField: UITextField!
    @IBOutlet private weak var addressTxtFeild: UITextField!
    @IBOutlet private weak var cityTxtFeild: UITextField!
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addOneBorderToTxtFeilds()
    }
    
    convenience init() {
        self.init(addressViewModel: nil)
    }

    init(addressViewModel: AddressViewModelType?) {
        self.addressViewModel = addressViewModel
        super.init(nibName: String(describing: AddressViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getCustomerAddress(){
        
    }
    /*
     case id
     case customerID = "customer_id"
     case address, city, country
     */
    
    func addOneBorderToTxtFeilds(){
        countryTxtField.addGrayBottomBorder()
        cityTxtFeild.addGrayBottomBorder()
        addressTxtFeild.addGrayBottomBorder()
    }
    
    @IBAction func goBack(_ sender: Any) {
        addressViewModel?.goBack()
    }
    @IBAction func addAddress(_ sender: Any) {
        if(addressViewModel?.validateInput() == true){
            
        }
    }
}