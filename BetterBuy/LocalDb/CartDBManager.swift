//
//  CartDBManager.swift
//  BetterBuy
//
//  Created by Mohamed Adel on 6/4/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import CoreData

class CartDBManager : CartDBManagerType {
    
    
    // MARK: - Variables
    
    var appDelegate: AppDelegate!
    var viewContext : NSManagedObjectContext!
    var entity : NSEntityDescription!
    
    private static var instance: CartDBManagerType?
    
    
    // MARK: - Init
    
    private init(appDelegate: AppDelegate){
        self.appDelegate = appDelegate
        self.viewContext = self.appDelegate.persistentContainer.viewContext
        self.entity = NSEntityDescription.entity(forEntityName: "Cart", in: self.viewContext)
    }
    
    static func getInstance(appDelegate: AppDelegate) -> CartDBManagerType {
        if instance == nil {
            instance = CartDBManager(appDelegate: appDelegate)
        }
        return instance!
    }
    //MARK:-  functionality of CoreData
    
    
    func getAllProductsInCart() -> [Product] {
        let fetchRequest = NSFetchRequest<Cart>(entityName: "Cart")
        
        var productsInCart : [Cart]?
        do{
            productsInCart = try viewContext.fetch(fetchRequest)
        }catch let error {
            print(error.localizedDescription)
        }
        var products : [Product]
        print(productsInCart!.description)
        products = Converter.convertCartProductToProduct(cartProducts: productsInCart!)
        //print(products[0])
        
        return products
    }
    
    func addToCart(product: Product) {
        print (product)
        let productInCart = convertProductToCartObj(product: product)
        do
        {
            try self.viewContext.save()
            print("*** product added *** ")
            print(productInCart.title ?? "Failed To add In Cart")
            
            print("productc added  In Cart= \(String(describing: productInCart.title)) **** \(String(describing: productInCart.sizes))")
            print("fav product price = \(String(describing: productInCart.price))")
            
        }
        catch
        {
            print("Cannot be added !!!")
        }
    }
    
    func removeProduct(product: Product) {
        let productToDelete = getProductWithId(id: "\(product.id!)")
        self.viewContext.delete(productToDelete[0])
        do{
            try self.viewContext.save()
        }
        catch{
            print("Item didn't delete successfully !!")
        }
    }
    
    func getProductWithId(id: String) -> [Cart] {
        let fetchRequest = NSFetchRequest<Cart>(entityName: "Cart")
        print(id)
        fetchRequest.predicate = NSPredicate(format: "productId == '\(id)'")
        var products: [Cart] = []
        do{
            products = try viewContext.fetch(fetchRequest)
            if products.count > 0 {
                print("****** get product from db \(products[0].productId ?? "error ")")
                print("****** id param \(id)")
                return products
            }
            return []
        }
        catch let error{
            print(error.localizedDescription)
            return []
        }
    }
    
    func isInCart(id: String) -> Bool {
        if getProductWithId(id: id).isEmpty {
            return false
        }
        return true
    }
    func plusCountByOne(id: String)->Int{
        let product = getProductWithId(id: "\(id)")
        let count  = (Int(product[0].count!) ?? 0) + 1
        product[0].count = String(count)
        do{
            try self.viewContext.save()
            return count
        }
        catch{
            print("Item didn't delete successfully !!")
            return -7
        }
    }
    
    func minusCountByOne(id: String)->Int {
        let product = getProductWithId(id: "\(id)")
        let count  = (Int(product[0].count!) ?? 0) - 1
        product[0].count = String(count)
        do{
            try self.viewContext.save()
            return count
            //if count reach 0 then delete product
        }
        catch{
            print("Item didn't delete successfully !!")
            return -7
        }
    }
    
    
    //MARK: - dataBase Helper
    private func convertProductToCartObj(product: Product) -> Cart {
        
        let productInCart = Cart(entity: self.entity, insertInto: viewContext)
        productInCart.productId = "\(product.id!)"
        productInCart.title = product.title!
        productInCart.price = product.variants![0].price
        productInCart.desc = product.description ?? "No desc"
        productInCart.count = "1"
        productInCart.vendor = product.vendor!
        productInCart.userId = String(getUserIDFromUserDeafault())
        // size
        var sizesStr = ""
        for size in product.options![0].values! {
            sizesStr.append(contentsOf: size)
            sizesStr.append("|")
        }
        sizesStr.removeLast()
        productInCart.sizes = sizesStr
        
        var imagesStr = ""
        for image in product.images! {
            imagesStr.append(contentsOf: image.src!)
            imagesStr.append("|")
        }
        
        imagesStr.removeLast()
        
        productInCart.images = imagesStr
        print(productInCart.title! + productInCart.price!)

        return productInCart
    }
    func getUserIDFromUserDeafault() -> String{
        guard let user : Customer = UserDefaults.getUserObject() else {return ""}
        return "\(user.id ?? 0)"
        //MARK:- USER ID
    }
}
