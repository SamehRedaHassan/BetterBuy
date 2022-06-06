//
//  AddressViewController.swift
//  BetterBuy
//
//  Created by nada elmasry on 6/4/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit
import RxSwift

class AddressViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet private weak var countryTxtField: UITextField!
    @IBOutlet private weak var cityTxtFeild: UITextField!
    @IBOutlet private weak var addressTxtFeild: UITextField!
    
    
    //MARK: properties
    var addressViewModel: AddressViewModelType?
    let disposeBag = DisposeBag()
    
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
    
    //MARK: Functions
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
        print("aaa")
        let validate = !( addressTxtFeild.text!.trimmingCharacters(in:.whitespaces).isEmpty && countryTxtField.text!.trimmingCharacters(in:.whitespaces).isEmpty && cityTxtFeild.text!.trimmingCharacters(in:.whitespaces).isEmpty)
        print(validate)
        if(validate){
            addressViewModel?.addAddress(country: countryTxtField.text!.trimmingCharacters(in: .whitespaces), city: cityTxtFeild.text!.trimmingCharacters(in: .whitespaces), address: addressTxtFeild.text!.trimmingCharacters(in: .whitespaces))
        }else {
            addressViewModel?.errorMsgSubject.onNext("Please Provide missing Data")
        }
    }
}
