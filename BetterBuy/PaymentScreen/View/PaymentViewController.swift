//
//  PaymentViewController.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/31/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit
import RxSwift
import PassKit
enum PaymentMethod {
    case cash
    case applePay
}

class PaymentViewController: BaseViewController {
    
    //MARK: IBOutlet
    @IBOutlet private weak var navBar: NavBar!
    @IBOutlet private weak var applePayImage: UIImageView!
    @IBOutlet private weak var cashOnDeliveryImage: UIImageView!
    @IBOutlet private weak var applePayButton: UIButton!
    @IBOutlet private weak var cashOnDeliveryButton: UIButton!
    @IBOutlet private weak var currentAddressLabel: UILabel!
    @IBOutlet private weak var shippingLabel: UILabel!
    @IBOutlet private weak var placeOrderButton: UIButton!
    @IBOutlet private weak var discountLabel: UILabel!
    @IBOutlet private weak var changeAddressButton: UIButton!
    @IBOutlet private weak var applyPromoButton: UIButton!
    @IBOutlet private weak var totalLabel: UILabel!
    @IBOutlet private weak var promoCodeTextField: UITextField!
    @IBOutlet private weak var subtotalLabel: UILabel!
    
    //MARK: Properties
    private var viewModel : PaymentViewModelType!
    private var paymentMethod  : PaymentMethod = .cash {
        didSet{
            if(paymentMethod == .cash){
                cashOnDeliveryImage.image = UIImage(named: "check")
                applePayImage.image =  UIImage(named: "uncheck")
            }else {
                cashOnDeliveryImage.image = UIImage(named: "uncheck")
                applePayImage.image =  UIImage(named: "check")
            }
        }
    }
    private var disposeBag   = DisposeBag()
    // MARK: - Life Cycle
    convenience init() {
        self.init(paymentViewModel: nil)
    }
    
    init(paymentViewModel: PaymentViewModelType?) {
        self.viewModel = paymentViewModel
        super.init(nibName: String(describing: PaymentViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        bindUI()
    }
    
    // MARK: - Functions
    private func configureNavBar(){
        self.navBar.coordinator = viewModel.coordinator
    }
    
    private func bindUI(){
        cashOnDeliveryButton.rx.tap.bind { [weak self] _ in
            guard let self = self else {return}
            self.paymentMethod = .cash
        }.disposed(by: disposeBag)
        
        applePayButton.rx.tap.bind { [weak self] _ in
            guard let self = self else {return}
            self.paymentMethod = .applePay
        }.disposed(by: disposeBag)
        
        placeOrderButton.rx.tap.subscribe {[weak self] event in
            guard let self = self else {return}
            
            if(self.paymentMethod == .applePay){
                self.payWithApple()
            }
        }.disposed(by: disposeBag)
        
    }
}
//MARK: - Extension Apple Pay
extension PaymentViewController :PKPaymentAuthorizationViewControllerDelegate{
    private func payWithApple(){
        
        let paymentItem = PKPaymentSummaryItem.init(label: "Total payment", amount: NSDecimalNumber(value: 1000.0))
        let paymentNetworks = [PKPaymentNetwork.amex, .discover, .masterCard, .visa]
        if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: paymentNetworks) {
            let request = PKPaymentRequest()
            request.currencyCode = "USD" // 1
            request.countryCode = "US" // 2
            request.merchantIdentifier = "merchant.com.pranavwadhwa.Shoe-Store" // 3
            request.merchantCapabilities = PKMerchantCapability.capability3DS // 4
            request.supportedNetworks = paymentNetworks // 5
            request.paymentSummaryItems = [paymentItem] // 6
            
            guard let paymentVC = PKPaymentAuthorizationViewController(paymentRequest: request) else {
                return
            }
            paymentVC.delegate = self
            self.present(paymentVC, animated: true, completion: nil)
        }
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true)
    }
}
