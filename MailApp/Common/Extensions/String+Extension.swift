//
//  String+Extension.swift
//  MailApp
//
//  Created by Santiago Avila Arroyave on 2/21/19.
//  Copyright © 2019 Santiago Avila Arroyave. All rights reserved.
//

import Foundation

extension String {
  func localized(context: AnyObject) -> String {
    return NSLocalizedString(self, comment: "")
  }
}
