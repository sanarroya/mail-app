//
//  NotificationAttributes.swift
//  MailApp
//
//  Created by Santiago Avila Arroyave on 2/23/19.
//  Copyright © 2019 Santiago Avila Arroyave. All rights reserved.
//

import Foundation
import SwiftEntryKit

struct Notification {
  static var attributes: EKAttributes {
    var attributes = EKAttributes.bottomFloat
    attributes.hapticFeedbackType = .error
    attributes.entryBackground = .gradient(gradient: .init(colors: [.amber, .pinky], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
    attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.3), scale: .init(from: 1, to: 0.7, duration: 0.7)))
    attributes.shadow = .active(with: .init(color: .black, opacity: 0.5, radius: 10))
    attributes.statusBar = .dark
    attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .easeOut)
    attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.bounds.minEdge), height: .intrinsic)
    return attributes
  }
}

