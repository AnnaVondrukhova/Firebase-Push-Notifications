//
//  AlertService.swift
//  Firebase Push Notifications
//
//  Created by Anya on 04.08.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import Foundation
import UIKit

class AlertService {
    
    static func newProductAlert(in vc: UIViewController, completion: @escaping (Product) -> Void) {
        let alertController = UIAlertController(title: "New product", message: nil, preferredStyle: .alert)
        alertController.addTextField { (tf) in
            tf.placeholder = "Product title"
        }
        alertController.addTextField { (tf) in
            tf.placeholder = "Product price"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let title = alertController.textFields?.first?.text,
                let costString = alertController.textFields?.last?.text,
                let cost = Double(costString) else {return}
            let product = Product(title: title, cost: cost)
            completion(product)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        vc.present(alertController, animated: true, completion: nil)
    }
    
    static func subscribeAlert(in vc: UIViewController) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let subscribeAction = UIAlertAction(title: "Subscribe", style: .default, handler: { (_) in
            FIRMessagingService.shared.subscribe(to: .newProduct)
        })
        let unsubscribeAction = UIAlertAction(title: "Unsubscribe", style: .default, handler: {(_) in
            FIRMessagingService.shared.unsubscribe(from: .newProduct)
        })
        
        alertController.addAction(subscribeAction)
        alertController.addAction(unsubscribeAction)
        vc.present(alertController, animated: true, completion: nil)
    }
}
