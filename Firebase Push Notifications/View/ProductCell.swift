//
//  ProductCell.swift
//  Firebase Push Notifications
//
//  Created by Anya on 04.08.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    func configure(with product: Product) {
        print("configure")
        titleLabel.text = product.title
        priceLabel.text = product.price()
    }
}
