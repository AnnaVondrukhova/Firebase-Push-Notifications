//
//  ViewController.swift
//  Firebase Push Notifications
//
//  Created by Anya on 04.08.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    var products = [Product]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProductService.shared.delegate = self
        ProductService.shared.observeProducts()
        
    }
    
    @IBAction func addProductBtnTapped(_ sender: Any) {
        AlertService.newProductAlert(in: self) { (product) in
            ProductService.shared.post(product: product)
        }
    }
    @IBAction func subscribeBtnTapped(_ sender: Any) {
        AlertService.subscribeAlert(in: self)
    }
    

}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as? ProductCell else { return UICollectionViewCell()}
        print(products)
        let product = products[indexPath.item]
        cell.configure(with: product)
        
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160.0, height: 180.0)
    }
}

extension ViewController: ProductServiceDelegate {
    func didReceive(products: [Product]) {
        self.products = products
        collectionView.reloadData()
    }
}
