//
//  FIRDatabaseService.swift
//  Firebase Push Notifications
//
//  Created by Anya on 04.08.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import Foundation
import Firebase

enum FIRDatabaseReferenceType: String {
    case product = "products"
}

class FIRDatabaseService {
    private init() {}
    
    static var shared = FIRDatabaseService()
    
    
    func reference(_ reference: FIRDatabaseReferenceType) -> DatabaseReference {
        return Firebase.Database.database().reference().child(reference.rawValue)
    }
    
    func observe(_ databaseReference: FIRDatabaseReferenceType, completion: @escaping (DataSnapshot) -> Void) {
        reference(databaseReference).observe(.value) { (dataSnapshot) in
            completion(dataSnapshot)
        }
    }
    
    func post(parameters: [String: Any], to databaseReference: FIRDatabaseReferenceType) {
        reference(databaseReference).childByAutoId().setValue(parameters)
    }
}
