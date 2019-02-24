//
//  UserAPIService.swift
//  MailApp
//
//  Created by Santiago Avila Arroyave on 2/23/19.
//  Copyright © 2019 Santiago Avila Arroyave. All rights reserved.
//

import Foundation

class UserService {
  
  private let networkAdapter: NetworkAdapter
  private let cacheAdapter: CacheAdapter
  
  init(networkAdapter: NetworkAdapter = NetworkAdapter(),
       cacheAdapter: CacheAdapter = CacheAdapter()) {
    self.networkAdapter = networkAdapter
    self.cacheAdapter = cacheAdapter
  }
  
  func getUser(withId id: Int, success: @escaping (User) -> (), failure: @escaping Failure) throws {
    guard let user = retrieveFromCache(withId: id) else {
      do {
        try fetchFromService(withId: id, success: success, failure: failure)
      } catch let error {
        throw error
      }
      return
    }
    success(user)
  }
  
  func deletePost(_ post: Post) {
    cacheAdapter.delete(object: post)
  }
  
  func deletePosts() {
    cacheAdapter.clear()
  }
}

private extension UserService {
  func retrieveFromCache(withId id: Int) -> User? {
    return cacheAdapter.retrieveUser(withId: id)
  }
  
  func fetchFromService(withId id: Int, success: @escaping (User) -> (), failure: @escaping Failure) throws {
    do {
      try networkAdapter.executeRequest(withPath: .user(id), withSuccess: { data in
        guard let data = data else {
          failure(NetworkError.invalidData)
          return
        }
        do {
          let user = try JSONDecoder().decode(User.self, from: data)
          self.cacheAdapter.save(user)
          success(user)
        } catch {
          failure(NetworkError.parseFailed)
        }
        
      }, failure: failure)
    } catch let error {
      throw error
    }
    
  }
}
