//
//  RegisterViewController.swift
//  BetterBuy
//
//  Created by nada elmasry on 5/25/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var createLoginLabel: UILabel!
    @IBOutlet weak var signInuserNameTxtView: UITextField!
    
    @IBOutlet weak var signInEmailTxtView: UITextField!
    @IBOutlet weak var signInPasswordTxtView: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBOutlet weak var btnCheckBox: UIButton!
    //MARK: variables
    var viewModel : RegisterViewModel?
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        signInuserNameTxtView.addBottomBorder()
        signInEmailTxtView.addBottomBorder()
        signInPasswordTxtView.addBottomBorder()
    }

    @IBAction func checkBoxBtn(_ sender: UIButton) {
        if (btnCheckBox.isSelected == true)
           {
            btnCheckBox.setBackgroundImage(UIImage(named: "box"), for: .normal)

            //btnCheckBox.isSelected = false;
           }
           else
           {
            btnCheckBox.setBackgroundImage(UIImage(named: "checkmark.square"), for: .selected)
            //btnCheckBox.isSelected = true;
           }
//        sender.isSelected = !sender.isSelected
//        sender.setT(sender.isSelected ? #imageLiteral(resourceName: "imgThree") : #imageLiteral(resourceName: "imgTwo"), for: .normal)
    
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


