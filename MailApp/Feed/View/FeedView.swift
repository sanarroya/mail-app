//
//  FeedView.swift
//  MailApp
//
//  Created by Santiago Avila Arroyave on 2/21/19.
//  Copyright © 2019 Santiago Avila Arroyave. All rights reserved.
//

import Foundation

protocol FeedView: class {
  func updateView()
  func startSpinner()
  func stopSpinner()
  func showError(_ error: Error)
}
