//
//  HomeViewController.swift
//  BetterBuy
//
//  Created by user222682 on 5/25/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//
//sameh
import UIKit
import RxSwift

class HomeViewController: UIViewController {
    let dp = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
getCustomers()
        // Do any additional setup after loading the view.
    }

    func getCustomers() {
        getApi(apiRouter: .getAllCustomers)
      //      .trackActivity(isLoading)
            .observeOn(MainScheduler.asyncInstance)
            .subscribe {[weak self] (event) in
                guard let `self` = self else { return }
                switch event {
                case .next(let result):
                    switch result {
                    case .success(value: let response):
                        print(response)
                    default:
                        print("EROOOOR")
//                    case .internetFailure(let error):
//                        self.Internetmsg.accept(error.message)
//
//                    case .failure(let error):
//                        self.msg.accept(error.message)
                    }
                default:
                    break
                }
            }.disposed(by: dp)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
