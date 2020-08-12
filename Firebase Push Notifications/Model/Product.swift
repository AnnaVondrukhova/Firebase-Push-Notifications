//
//  Product.swift
//  Firebase Push Notifications
//
//  Created by Anya on 04.08.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import Foundation

struct Product {
    let title: String
    let cost: Double
    
    init(title: String, cost: Double) {
        self.title = title
        self.cost = cost
    }
    
    init?(dictionary: [String:Any]) {
        guard let title = dictionary["title"] as? String,
            let cost = dictionary["cost"] as? Double else { return nil }
        self.title = title
        self.cost = cost
    }
    
    func price() -> String {
        let costString = String(format: "%.2f", cost)
        return "$" + costString
    }
    
    func parameters() -> [String: Any] {
        let dict = ["title": title, "cost": cost] as [String : Any]
        return dict
    }
}
