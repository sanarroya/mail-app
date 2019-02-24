//
//  DetailView.swift
//  MailApp
//
//  Created by Santiago Avila Arroyave on 2/23/19.
//  Copyright © 2019 Santiago Avila Arroyave. All rights reserved.
//

import Foundation

protocol DetailView: class {
  func updateView(_ user: User)
  func startSpinner()
  func stopSpinner()
  func showError(_ error: Error)
}
