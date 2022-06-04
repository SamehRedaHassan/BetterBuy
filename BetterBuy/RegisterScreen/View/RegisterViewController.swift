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
import Loaf

class RegisterViewController: BaseViewController {
    
    //MARK: Outlets
    @IBOutlet weak var LoginBtn: UIButton!
    @IBOutlet weak var signInuserNameTxtView: UITextField! {
        didSet{
            signInuserNameTxtView.rx.text.orEmpty
                .bind(to: viewModel.userNameSubject)
                    .disposed(by: disposeBag)
        }
    }
    @IBOutlet weak var signInEmailTxtView: UITextField! {
        didSet{
            signInEmailTxtView.rx.text.orEmpty
                .bind(to: viewModel.emailSubject)
                    .disposed(by: disposeBag)
        }
    }
    @IBOutlet weak var signInPasswordTxtView: UITextField!{
        didSet{
            signInPasswordTxtView.rx.text.orEmpty
                .bind(to: viewModel.passwordSubject)
                    .disposed(by: disposeBag)
        }
    }
    @IBOutlet weak var confirmPassword: UITextField!{
        didSet{
            confirmPassword.rx.text.orEmpty
                .bind(to: viewModel.confirmPasswordSubject)
                    .disposed(by: disposeBag)
        }
    }
    @IBOutlet weak var signUpBtn: UIButton!
    
    //MARK: variables
    var viewModel : RegisterViewModelType
    let disposeBag = DisposeBag()
    
    //MARK: LifeCycle
    
    init(viewModel : RegisterViewModelType) {
           self.viewModel = viewModel
           super.init(nibName: String(describing: RegisterViewController.self), bundle: nil)
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInuserNameTxtView.addBottomBorder()
        signInEmailTxtView.addBottomBorder()
        signInPasswordTxtView.addBottomBorder()
        confirmPassword.addBottomBorder()
        BindButtons()
    }

    
    func BindButtons(){
        viewModel.isLoading
                    .distinctUntilChanged()
                   .drive(onNext: { [weak self] (isLoading) in
                       guard let self = self else { return }
                       self.killLoading()
                       if isLoading {
                           self.loading()
                       }
                   }).disposed(by: disposeBag)
        
        LoginBtn.rx.tap.bind{
            self.viewModel.goToLoginScreen()
        }.disposed(by: disposeBag)
        
        
        signUpBtn.rx.tap.bind{ [weak self] in
            guard let self = self else {return}
            if(self.viewModel.validateInput()){
                self.viewModel.registerUser()
            }
        }.disposed(by: disposeBag)
        
        
        viewModel.errorMsgSubject.asObservable().observeOn(ConcurrentDispatchQueueScheduler.init(qos: .userInitiated)).asDriver(onErrorJustReturn: "").drive(onNext: { (str) in
            guard str != "" else {return}
            Loaf(str ?? "Please provide valid input", state: .custom(.init(backgroundColor: .black, icon: UIImage(systemName: "info"))), sender: self).show()
        }).disposed(by: disposeBag)
    }
}


//MARK: Extentions
extension UITextField {
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width - 30, height: 1)
        bottomLine.backgroundColor = UIColor.white.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}


