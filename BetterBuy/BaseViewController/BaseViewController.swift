//
//  BaseViewController.swift
//  BetterBuy
//
//  Created by user222682 on 5/25/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class BaseViewController: UIViewController ,NVActivityIndicatorViewable{

    func toogleTabbar(hide: Bool) {
        guard let tabBar = tabBarController as? TabBarContoller else { return }
        tabBar.toggle(hide: hide)
    }
    
    func animateTheHeightOfTheView(height : CGFloat ,view : UIView){
        view.layoutIfNeeded() // force any pending operations to finish

        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            view.constrainHeight(constant: height)
            self.view.layoutIfNeeded()
        })
    }
    func loading(){
        startAnimating(.init(width: 50, height: 50), message: "Loading...", messageFont: nil, type: .lineScale, color: .black, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: .clear, textColor: nil, fadeInAnimation: nil)
    }

    func killLoading(){
        stopAnimating()
    }
    
    func dismissTopVC(){
        if let _ = self.navigationController {
            self.navigationController?.popViewController(animated: true)
        }else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func getNoDataViewWith (image : UIImage , head : String )-> UIView{
        let redView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 400))
        redView.backgroundColor = .clear
        
        
        let noDataImageView = UIImageView()
        noDataImageView.backgroundColor = .clear
        noDataImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        noDataImageView.widthAnchor.constraint(equalToConstant: 110).isActive = true
        noDataImageView.contentMode = .scaleAspectFit
        noDataImageView.image = image
        
        let headerLabel = UILabel()
        headerLabel.backgroundColor = UIColor.clear
        headerLabel.widthAnchor.constraint(equalToConstant: 220.0).isActive = true
        headerLabel.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont(name: Resources.Fonts.Weight.semibold.rawValue, size: 18)!
        headerLabel.textColor = .black
        headerLabel.text = head


        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 0
     
        stackView.addArrangedSubview(noDataImageView)
        stackView.addArrangedSubview(headerLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        redView.addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: redView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: redView.centerYAnchor).isActive = true
        
    
        return redView
    }
    
//    func setupAppearanceForTipView(){
//        var preferences = EasyTipView.Preferences()
//        preferences.drawing.font = Fonts.CairoRegular.regular(of: 14)
//        preferences.drawing.foregroundColor = UIColor.white
//        preferences.drawing.backgroundColor = .black
//        preferences.drawing.arrowPosition = EasyTipView.ArrowPosition.top
//        // Optionally you can make these preferences global for all future EasyTipViews
//        EasyTipView.globalPreferences = preferences
//    }
}

