//
//  ProductsService.swift
//  Firebase Push Notifications
//
//  Created by Anya on 05.08.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import Foundation

protocol ProductServiceDelegate {
    func didReceive(products: [Product])
}

class ProductService {
    private init() {}
    
    static var shared = ProductService()
    var delegate: ProductServiceDelegate?
    
    func observeProducts() {
        FIRDatabaseService.shared.observe(.product) { (snaphot) in
            guard let products = ProductsSnaphot(with: snaphot)?.products else {return}
            self.delegate?.didReceive(products: products)
        }
    }
    
    func post(product: Product) {
        let parameters = product.parameters()
        FIRDatabaseService.shared.post(parameters: parameters, to: .product)
    }
}
