//
//  APIClient.swift
//  MailApp
//
//  Created by Santiago Avila Arroyave on 2/22/19.
//  Copyright © 2019 Santiago Avila Arroyave. All rights reserved.
//

import Foundation
import Alamofire

protocol APIClientProtocol {
  func execute(_ request: NetworkRequestable)
}

class APIClient: APIClientProtocol {
  
  func execute(_ request: NetworkRequestable) {
    Alamofire.request(request.url)
    .validate()
      .responseData { response in
        switch response.result {
          case .success:
            request.success(response.data)
          case .failure(let error):
            request.failure(error)
        }
    }
  }
}
