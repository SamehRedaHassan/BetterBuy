//
//  LoginViewController.swift
//  BetterBuy
//
//  Created by Mohamed Adel on 5/29/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Loaf

class LoginViewController: BaseViewController  {
    //MARK: - IBOutlets

    let disposeBag = DisposeBag()
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet private weak var emailTxtView: UITextField!{
        didSet{
            emailTxtView.rx.text.orEmpty
                .bind(to: viewModel!.emailSubject)
                .disposed(by: disposeBag)

        }
    }
    @IBOutlet weak var passwordTxtView: UITextField!{
        didSet{
            passwordTxtView.rx.text.orEmpty
                .bind(to: viewModel!.passwordSubject)
                .disposed(by: disposeBag)

        }
    }
    //MARK: - Properties
    var viewModel : LoginViewModelType?
    
    
    // MARK: - Life Cycle
    convenience init() {
        self.init(viewModel: nil)
    }

    init(viewModel: LoginViewModelType?) {
        self.viewModel = viewModel
        super.init(nibName: "LoginView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getAllCustomersData()
        emailTxtView.addBottomBorder()
        passwordTxtView.addBottomBorder()
        bindingBtn()
    }
    
    deinit {
        print("deinitializing login screen")
    }
    
    //MARK: - IBAction
    @IBAction func navigateToSignup(_ sender: UIButton) {
        viewModel?.navigateToSignup()
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        viewModel?.goBack()
    }
    //MARK:-Functions
    func bindingBtn(){
        viewModel?.isLoading
            .distinctUntilChanged()
            .drive(onNext: { [weak self] (isLoading) in
                guard let self = self else { return }
                self.killLoading()
                if isLoading {
                    self.loading()
                }
            }).disposed(by: disposeBag)
        
        loginBtn.rx.tap.bind { [weak self] in
            guard let self = self else {return}
            if(self.viewModel?.validateInput() ?? false){
                self.viewModel?.checkUserInput()
            }
        }.disposed(by: disposeBag)
        
        viewModel?.errorMsgSubject.asObservable().observeOn(ConcurrentDispatchQueueScheduler.init(qos: .userInitiated)).asDriver(onErrorJustReturn: "").drive(onNext: { (str) in
                   guard str != "" else {return}
                   Loaf(str ?? "Please provide valid input", state: .custom(.init(backgroundColor: .black, icon: UIImage(systemName: "info"))), sender: self).show()
               }).disposed(by: disposeBag)
        
    }
}
