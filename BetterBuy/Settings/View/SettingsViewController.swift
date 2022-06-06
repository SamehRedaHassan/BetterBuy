//
//  SettingsViewController.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/25/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit
import PopupDialog

class SettingsViewController: UIViewController {

    //MARK: IBOutlet
    @IBOutlet weak var currencyBtn: UIButton!
    @IBOutlet weak var navBar: NavBar!
    
    
    //MARK: variables
    var viewModel : SettingsViewModelType?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
    }
    
    convenience init() {
        self.init(settingsViewModel: nil)
    }

    init(settingsViewModel: SettingsViewModelType?) {
        self.viewModel = settingsViewModel
        super.init(nibName: String(describing: SettingsViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinitializing settings screen")
    }
    
    // MARK: - Functions
    private func setupNavbar(){
        self.navBar.coordinator = viewModel?.coordinator
    }
    
    func setUpDialog(title : String , msg : String , imageName : String ) -> PopupDialog{
           // Customize dialog appearance
           let pv = PopupDialogDefaultView.appearance()
           pv.titleFont    = UIFont(name: "HelveticaNeue-Light", size: 16)!
           pv.titleColor   = .white
           pv.messageFont  = UIFont(name: "HelveticaNeue", size: 14)!
           pv.messageColor = UIColor(white: 0.8, alpha: 1)

           // Customize the container view appearance
           let pcv = PopupDialogContainerView.appearance()
           pcv.backgroundColor = UIColor(red:0.23, green:0.23, blue:0.27, alpha:1.00)
           //pcv.cornerRadius    = 2
           pcv.shadowEnabled   = true
           pcv.shadowColor     = .black

           // Customize overlay appearance
           let ov = PopupDialogOverlayView.appearance()
           ov.blurEnabled     = true
           ov.blurRadius      = 30
           ov.liveBlurEnabled = true
           ov.opacity         = 0.7
           ov.color           = .black

           // Customize default button appearance
           let db = DefaultButton.appearance()
           db.titleFont      = UIFont(name: "HelveticaNeue-Medium", size: 14)!
           db.titleColor     = .white
           db.buttonColor    = UIColor(red:0.25, green:0.25, blue:0.29, alpha:1.00)
           db.separatorColor = UIColor(red:0.20, green:0.20, blue:0.25, alpha:1.00)

           // Customize cancel button appearance
           let cb = CancelButton.appearance()
           cb.titleFont      = UIFont(name: "HelveticaNeue-Medium", size: 14)!
           cb.titleColor     = UIColor(white: 0.6, alpha: 1)
           cb.buttonColor    = UIColor(red:0.25, green:0.25, blue:0.29, alpha:1.00)
           cb.separatorColor = UIColor(red:0.20, green:0.20, blue:0.25, alpha:1.00)
           let title = title
           let message = msg
        let image = UIImage(named: imageName)
           // Create the dialog
           let popup = PopupDialog(title: title, message: message, image: image)
           // Create buttons
           let buttonOne = DefaultButton(title: "EG") {
            UserDefaults.standard.set("EG", forKey: "currency")
            self.dismiss(animated: true, completion: nil)
           }

           // This button will not the dismiss the dialog
           let buttonTwo = DefaultButton(title: "USD", dismissOnTap: true) {
            UserDefaults.standard.set("USD", forKey: "currency")
           }

           let buttonThree = CancelButton(title: "Cancel", height: 60) {
               self.dismiss(animated: true, completion: nil)
           }
           popup.addButtons([buttonOne, buttonTwo, buttonThree])
            return popup
       }
    
    
    func setUpConfirmationDialog(title : String , msg : String , imageName : String ) -> PopupDialog{
        let pv = PopupDialogDefaultView.appearance()
        pv.titleFont    = UIFont(name: "HelveticaNeue-Light", size: 16)!
        pv.titleColor   = .white
        pv.messageFont  = UIFont(name: "HelveticaNeue", size: 14)!
        pv.messageColor = UIColor(white: 0.8, alpha: 1)
        let pcv = PopupDialogContainerView.appearance()
        pcv.backgroundColor = UIColor(red:0.23, green:0.23, blue:0.27, alpha:1.00)
        //pcv.cornerRadius    = 2
        pcv.shadowEnabled   = true
        pcv.shadowColor     = .black
        let ov = PopupDialogOverlayView.appearance()
        ov.blurEnabled     = true
        ov.blurRadius      = 30
        ov.liveBlurEnabled = true
        ov.opacity         = 0.7
        ov.color           = .black
        let db = DefaultButton.appearance()
        db.titleFont      = UIFont(name: "HelveticaNeue-Medium", size: 14)!
        db.titleColor     = .white
        db.buttonColor    = UIColor(red:0.25, green:0.25, blue:0.29, alpha:1.00)
        db.separatorColor = UIColor(red:0.20, green:0.20, blue:0.25, alpha:1.00)
        let cb = CancelButton.appearance()
        cb.titleFont      = UIFont(name: "HelveticaNeue-Medium", size: 14)!
        cb.titleColor     = UIColor(white: 0.6, alpha: 1)
        cb.buttonColor    = UIColor(red:0.25, green:0.25, blue:0.29, alpha:1.00)
        cb.separatorColor = UIColor(red:0.20, green:0.20, blue:0.25, alpha:1.00)
        let title = title
        let message = msg
        let image = UIImage(named: imageName )
        let popup = PopupDialog(title: title, message: message, image: image)
        let buttonOne = DefaultButton(title: "Yes") {
        self.viewModel?.logOutUser()
        self.dismiss(animated: true, completion: nil)
        }

        let buttonTwo = CancelButton(title: "Stay logged in", dismissOnTap: true) {
        }

        popup.addButtons([buttonOne, buttonTwo])
         return popup
    }
       

    
    
    // MARK: - IBAction
    @IBAction func currencyBtnAction(_ sender: Any) {
        print("clicked")
        let popupDialog = setUpDialog(title: "Currency", msg: "Pick your prefarable currency", imageName: "whitemoney")
        self.present(popupDialog, animated: true, completion: nil)
    }
    
    @IBAction func locationBtn(_ sender: Any) {
        viewModel?.goToLocationScreen()
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        print("clicked")
        let popUp = setUpConfirmationDialog(title: "Alert", msg: "Are you sure you want to logOut?", imageName: "logout")
        self.present(popUp, animated: true, completion: nil)
    }
    
   
}

