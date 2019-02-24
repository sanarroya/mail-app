//
//  NetworkManager.swift
//  MailApp
//
//  Created by Santiago Avila Arroyave on 2/22/19.
//  Copyright © 2019 Santiago Avila Arroyave. All rights reserved.
//

import Foundation

enum NetworkError: LocalizedError {
  
  case invalidHost
  case parseFailed
  case invalidData
  
  var errorDescription: String? {
    switch self {
      case .invalidHost:
        return "Error.InvalidHost".localized(context: self as AnyObject)
      case .parseFailed:
        return "Error.ParseFailed".localized(context: self as AnyObject)
      case .invalidData:
        return "Error.InvalidData".localized(context: self as AnyObject)
    }
  }
}

enum APIPath {
  
  case posts
  case comments(String)
  case user(Int)
  
  var rawValue: String {
    switch self {
      case .posts:
        return "posts"
      case .comments(let postId):
        return String(format: "/posts/%@/comments", postId)
      case .user(let userId):
        return String(format: "/users/%d", userId)
    }
  }
}

class NetworkAdapter {
  
  private let client: APIClientProtocol
  
  private var baseURL: URL? {
    get {
      return URL(string: Constants.host)
    }
  }
  
  init(client: APIClientProtocol = APIClient()) {
    self.client = client
  }
  
  func executeRequest(withPath path: APIPath, withSuccess success: @escaping Success, failure: @escaping Failure) throws {
    guard var url = baseURL else {
      throw NetworkError.invalidHost
    }
    
    url.appendPathComponent(path.rawValue)
    
    let request = NetworkRequest(
      url: url,
      success: success,
      failure: failure
    )
    
    client.execute(request)
  }
}

private extension NetworkAdapter {
  
  struct Constants {
    static let host = "https://jsonplaceholder.typicode.com"
  }
}
