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
        let encoder = JSONEncoder()
        let user = try! encoder.encode(user)
        UserDefaults.standard.set(user, forKey: "user")
        //UserDefaults.getUserObject()
    }
    
    static func getUserObject() -> Customer?{
        if let data = UserDefaults.standard.object(forKey: "user") {
                do {
                    let decoder = JSONDecoder()
                    let note = try decoder.decode(Customer.self, from: data as! Data)
                    print (note.email!)
                    return note
                } catch {
                    print("Unable to Decode Note (\(error))")
                }
            }
        return nil
    }
    
    static func saveUserId(id : String){
        UserDefaults.standard.set(id, forKey: "id")
    }
    
    static func saveUserName(name : String){
        UserDefaults.standard.set(name , forKey: "id")
    }
    
    static func saveUserEmail(name : String){
        UserDefaults.standard.set(name , forKey: "id")
    }
    
}
