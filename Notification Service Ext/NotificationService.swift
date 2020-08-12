//
//  NotificationService.swift
//  Notification Service Ext
//
//  Created by Anya on 12.08.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            guard let imageUrlString = bestAttemptContent.userInfo["imageUrl"] as? String else {
                contentHandler(request.content)
                return
            }
            
            DownloadService.shared.getImageUrl(urlString: imageUrlString) { url in
                do {
                    let attachment = try UNNotificationAttachment(identifier: "contentImage", url: url, options: nil)
                    bestAttemptContent.attachments = [attachment]
                    contentHandler(bestAttemptContent)
                } catch {
                    print(error.localizedDescription)
                    contentHandler(bestAttemptContent)
                }
            }
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}
