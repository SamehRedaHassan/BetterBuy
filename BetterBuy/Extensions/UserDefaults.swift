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
    
    static func saveLoginStatus( _Val:Bool){
        UserDefaults.standard.set(_Val, forKey: "isLoggedIn")
    }
    
    static func getLoginStatus() -> Bool{
        let  _val = UserDefaults.standard.bool(forKey: "isLoggedIn")
        return _val
    }
    
     func getFontFamily(){
        for family in UIFont.familyNames.sorted(){
            let Names = UIFont.fontNames(forFamilyName: family)
            print("Family : \(family) font name \(Names)")
        }
    }
    
    static func saveUserObject(user : Customer){
        UserDefaults.standard.set(user, forKey: "user")
    }
    
    static func getUserObject() -> Customer?{
        if let user : Customer = UserDefaults.standard.object(forKey: "user") as? Customer{
            return user
        } else {
            return nil
        }
    }
    
}
