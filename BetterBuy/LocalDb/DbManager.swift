//
//  DbManager.swift
//  BetterBuy
//
//  Created by nada elmasry on 6/2/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import Foundation
import CoreData

class DbManager : LocalDbType {
    
    // MARK: - Variables
    
    var appDelegate: AppDelegate!
    var viewContext : NSManagedObjectContext!
    var entity : NSEntityDescription!
    
    private static var instance: LocalDbType?
    
    
    // MARK: - Init
    
    private init(appDelegate: AppDelegate){
        self.appDelegate = appDelegate
        self.viewContext = self.appDelegate.persistentContainer.viewContext
        self.entity = NSEntityDescription.entity(forEntityName: "Favourite", in: self.viewContext)
    }
    
    static func getInstance(appDelegate: AppDelegate) -> LocalDbType {
        if instance == nil {
            instance = DbManager(appDelegate: appDelegate)
        }
        return instance!
    }
    
    // MARK: - Add Product To DB
    
    
    func addFavProduct(product : Product) {
        
        let favProduct = productToFavouriteProduct(product: product)
        do
        {
            try self.viewContext.save()
            print("*** product added *** ")
            //print(favProduct)
            
            print("productc added = \(favProduct.title) **** \(favProduct.sizes)")
            print("fav product price = \(favProduct.price)")

        }
        catch
        {
            print("Cannot be added !!!")
        }
    }
    
    
    private func productToFavouriteProduct(product: Product) -> Favourite {
        
        let favouriteProduct = Favourite(entity: self.entity, insertInto: viewContext)
        favouriteProduct.productId = "\(product.id!)"
        favouriteProduct.title = product.title!
        favouriteProduct.price = product.variants![0].price
        favouriteProduct.desc = product.description ?? "No desc"
                
        // size
        var sizesStr = ""
        for size in product.options![0].values! {
            sizesStr.append(contentsOf: size)
            sizesStr.append("|")
        }
        sizesStr.removeLast()
        favouriteProduct.sizes = sizesStr
        
        var imagesStr = ""
        for image in product.images! {
            imagesStr.append(contentsOf: image.src!)
            imagesStr.append("|")
        }
        
        imagesStr.removeLast()
        
        favouriteProduct.images = imagesStr
        return favouriteProduct
    }
    
    
    // MARK: - Check In fav
    
    func isInFavorites(id: String) -> Bool {
        if getFavItemFromDbWithId(id: id).isEmpty {
            return false
        }
        return true
    }
    
    // MARK: - getAllFavourites
    
    func getAllFavourites() -> [Product] {
        let fetchRequest = NSFetchRequest<Favourite>(entityName: "Favourite")
        
        var favouritesProducts : [Favourite]?
        do{
            favouritesProducts = try viewContext.fetch(fetchRequest)
        }catch let error {
            print(error.localizedDescription)
        }
        var products : [Product]
        print(favouritesProducts!.description)
        products = Converter.convertFavouriteProductsToProducts(favouriteProducts: favouritesProducts!)
        //print(products[0])

        return products
    }
    
    
    
    // MARK: - getProductWithId
    
    func getFavItemFromDbWithId(id: String) -> [Favourite] {
        let fetchRequest = NSFetchRequest<Favourite>(entityName: "Favourite")
        fetchRequest.predicate = NSPredicate(format: "productId == %@", id)
        var products: [Favourite] = []
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
    
    // MARK: - Remove Product From DB
    
    func removeFavProduct(product : Product){
        print(product.id)
        //var productToDelete = productToStoredProduct(product: product)
        var productToDelete = getFavItemFromDbWithId(id: "\(product.id!)")
        //print(productToDelete[0].title)
        //print(productToDelete[0].productId)
        self.viewContext.delete(productToDelete[0])
        //print("*** product removed *** ")
        
        do{
            try self.viewContext.save()
        }
        catch{
            print("Item didn't delete successfully !!")
        }
    }
    
    
}

