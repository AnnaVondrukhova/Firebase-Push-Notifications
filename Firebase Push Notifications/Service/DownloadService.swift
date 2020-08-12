//
//  DownloadService.swift
//  Firebase Push Notifications
//
//  Created by Anya on 12.08.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import Foundation

class DownloadService {
    private init() {}
    static let shared = DownloadService()
    
    func getImageUrl(urlString: String, completion: @escaping (URL) -> Void) {
        guard let url = URL(string: urlString) else { return }
    
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let fileManager = FileManager.default
            
            guard let data = data,
                let directoryPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
            
            let imagePath = directoryPath.appendingPathComponent("contentImage.jpg")
            
            do {
                try data.write(to: imagePath)
                DispatchQueue.main.async {
                    completion(imagePath)
                }
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
}
