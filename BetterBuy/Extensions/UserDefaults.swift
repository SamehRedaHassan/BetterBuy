//
//  UserDefaults.swift
//  BetterBuy
//
//  Created by user222682 on 6/3/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//
import Foundation
import  UIKit
extension UserDefaults {

   static func isFirstLaunch() -> Bool {
        let hasBeenLaunchedBeforeFlag = "hasBeenLaunchedBeforeFlag"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunchedBeforeFlag)
        if (isFirstLaunch) {
            UserDefaults.standard.set(true, forKey: hasBeenLaunchedBeforeFlag)
        }
        return isFirstLaunch
    }
    
     func getFontFamily(){
        for family in UIFont.familyNames.sorted(){
            let Names = UIFont.fontNames(forFamilyName: family)
            print("Family : \(family) font name \(Names)")
        }
    }
    
}
