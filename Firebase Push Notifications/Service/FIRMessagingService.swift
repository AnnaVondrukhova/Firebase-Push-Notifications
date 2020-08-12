//
//  FIRMessagingService.swift
//  Firebase Push Notifications
//
//  Created by Anya on 05.08.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import Foundation
import Firebase
import Messages

enum SubscriptionTopic: String {
    case newProduct = "newProduct"
}

class FIRMessagingService {
    private init() {}
    static let shared = FIRMessagingService()
    let messaging = Messaging.messaging()
    
    func subscribe(to topic: SubscriptionTopic) {
        messaging.subscribe(toTopic: topic.rawValue)
    }
    
    func unsubscribe(from topic: SubscriptionTopic) {
        messaging.unsubscribe(fromTopic: topic.rawValue)
    }
}
