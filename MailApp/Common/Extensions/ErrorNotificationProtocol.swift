//
//  ErrorNotificationProtocol.swift
//  MailApp
//
//  Created by Santiago Avila Arroyave on 2/24/19.
//  Copyright © 2019 Santiago Avila Arroyave. All rights reserved.
//

import UIKit
import SwiftEntryKit

protocol NotificationProtocol {
  func showError(withMessage message: String, imageName: String?)
}

extension NotificationProtocol where Self: UIViewController {
  func showError(withMessage message: String, imageName: String? = nil) {
    let title = EKProperty.LabelContent(text: "Error.Title".localized(context: self), style: .init(font: .boldSystemFont(ofSize: 16), color: .white))
    let description = EKProperty.LabelContent(text: message, style: .init(font: .systemFont(ofSize: 14), color: .white))
    var image: EKProperty.ImageContent?
    if let imageName = imageName {
      image = .init(image: UIImage(named: imageName)!, size: CGSize(width: 35, height: 35))
    }
    
    let simpleMessage = EKSimpleMessage(image: image, title: title, description: description)
    let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
    
    let contentView = EKNotificationMessageView(with: notificationMessage)
    SwiftEntryKit.display(entry: contentView, using: Notification.attributes)
  }
}
