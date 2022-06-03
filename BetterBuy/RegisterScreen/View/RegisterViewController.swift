//
//  RegisterViewController.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/25/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//
import UIKit
import RxSwift
import RxCocoa

class RegisterViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var LoginBtn: UIButton!
    @IBOutlet weak var signInuserNameTxtView: UITextField!
    
    @IBOutlet weak var signInEmailTxtView: UITextField!
    @IBOutlet weak var signInPasswordTxtView: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    //MARK: variables
    var viewModel : RegisterViewModelType
    let disposeBag = DisposeBag()
    
    init(viewModel : RegisterViewModelType) {
           self.viewModel = viewModel
           super.init(nibName: String(describing: RegisterViewController.self), bundle: nil)
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        signInuserNameTxtView.addBottomBorder()
        signInEmailTxtView.addBottomBorder()
        signInPasswordTxtView.addBottomBorder()
        BindButtons()
    }
    
    func BindButtons(){
        
        LoginBtn.rx.tap.bind{
            self.viewModel.goToLoginUpScreen()
            
            print ("Clicked")
        }.disposed(by: disposeBag)
        signUpBtn.rx.tap.bind{
            
        }.disposed(by: disposeBag)

    }

}


//MARK: Extentions
extension UITextField {
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor.white.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}


