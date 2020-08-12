//
//  ProductsSnaphot.swift
//  Firebase Push Notifications
//
//  Created by Anya on 05.08.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import Foundation
import Firebase

struct ProductsSnaphot {
    var products = [Product]()
    
    init?(with snaphot: DataSnapshot) {
        guard let productsSnaphot = snaphot.value as? [String: [String:Any]] else {return nil}
        var products = [Product]()
        
        for snaphotDict in productsSnaphot.values {
            guard let product = Product(dictionary: snaphotDict) else {continue}
            products.append(product)
        }
        
        self.products = products
    }
}
