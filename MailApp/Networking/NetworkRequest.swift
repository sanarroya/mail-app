//
//  NetworkRequest.swift
//  MailApp
//
//  Created by Santiago Avila Arroyave on 2/23/19.
//  Copyright © 2019 Santiago Avila Arroyave. All rights reserved.
//

import Foundation

typealias Success = (Data?) -> ()
typealias Failure = (Error) -> ()

protocol NetworkRequestable {
  var url: URL { get }
  var success: Success { get }
  var failure: Failure { get }
}

struct NetworkRequest: NetworkRequestable {
  var url: URL
  var success: Success
  var failure: Failure
}
