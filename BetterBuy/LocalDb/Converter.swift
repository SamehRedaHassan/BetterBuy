//
//  Converter.swift
//  BetterBuy
//
//  Created by nada elmasry on 6/2/22.
//

import Foundation

class Converter {
    
    static func formatProductName(productTitle: String) -> String {
        let parts = productTitle.split(separator: "|")
        return String(parts[parts.count - 1])
    }
    
    static func formatStringToArray(str : String) -> [String]{
        
        let images = str.split(separator: "|")
        var imagesStr : [String] = []
//        imagesStr = String(images)
        for image in images {
            imagesStr.append(String(image))
        }
        return imagesStr
    }
    
    
        
    static func separateStringArray(stringArray : [String]) -> String {
        var str = ""
        for element in stringArray {
            str.append(contentsOf: element)
            str.append("|")
        }
        str.removeLast()
        return str
    }
    
    static func convertFavouriteProductsToProducts(favouriteProducts: [Favourite]) -> [Product] {
        
        return favouriteProducts.map { favouriteProduct -> Product in
            var product = Product()
            var colors : [String] = []
            var sizes : [String] = []
           // print("**** fav product sizes converted **** \(favouriteProduct.sizes)")
            sizes = formatStringToArray(str: favouriteProduct.sizes!)
            //sizes.append(favouriteProduct.sizes!)
            
            product.id = Int(favouriteProduct.productId ?? "No Id Provided")
            if !favouriteProduct.price!.isEmpty {
           //     print(favouriteProduct.price)
            }
            else{
              //  print("noooooooo priceeeeee")
            }
            //print(favouriteProduct.price)
            product.variants = []
            product.variants?.append(Variant(price: favouriteProduct.price ?? "No Price"))
            product.title = favouriteProduct.title
            product.options?.append(ProductOption(sizes : sizes))
            
            product.description = favouriteProduct.desc!
            //print(product.description)
            let images : [String] = formatStringToArray(str: (favouriteProduct.images)!)
            product.images = []
            for image in images {
                product.images?.append(ProductImage(src: image))
            }
            return product
        }
    }
    
    static func convertCartProductToProduct(cartProducts: [Cart]) -> [Product] {
        
        return cartProducts.map { cartProduct -> Product in
        
            var product = Product()

            product.id = Int(cartProduct.productId ?? "0")
            product.title = cartProduct.title
            product.description = cartProduct.desc
            product.vendor = cartProduct.vendor
            product.tags = cartProduct.userId
            product.variants = []
            product.variants?.append(Variant(price: cartProduct.price ?? "No Price"))
            let sizes : [String] = formatStringToArray(str: cartProduct.sizes!)
            product.options?.append(ProductOption(sizes: sizes))
            
            let images : [String] = formatStringToArray(str: (cartProduct.images)!)
            product.images = []
            for image in images {
                product.images?.append(ProductImage(src: image))
            }
             product.count = Int(cartProduct.count!) ?? 0
            
            return product
        }
    
    }
}
