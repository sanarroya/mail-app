//
//  CGRect+Extension.swift
//  MailApp
//
//  Created by Santiago Avila Arroyave on 2/24/19.
//  Copyright © 2019 Santiago Avila Arroyave. All rights reserved.
//

import UIKit

extension CGRect {
  var minEdge: CGFloat {
    return min(width, height)
  }
}

