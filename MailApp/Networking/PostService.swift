//
//  PostAPIService.swift
//  MailApp
//
//  Created by Santiago Avila Arroyave on 2/22/19.
//  Copyright © 2019 Santiago Avila Arroyave. All rights reserved.
//

import Foundation

class PostService {
  
  private let networkAdapter: NetworkAdapter
  private let cacheAdapter: CacheAdapter
  
  init(networkAdapter: NetworkAdapter = NetworkAdapter(),
       cacheAdapter: CacheAdapter = CacheAdapter()) {
    self.networkAdapter = networkAdapter
    self.cacheAdapter = cacheAdapter
  }
  
  func getPosts(withSuccess success: @escaping ([Post]) -> (), failure: @escaping Failure) throws {
    let posts = retrieveFromCache()
    guard posts.isEmpty else {
      success(posts)
      return
    }
    
    do {
      try fetchFromService(withSuccess: success, failure: failure)
    } catch let error {
      throw error
    }
  }
  
  func deletePost(_ post: Post) {
    cacheAdapter.delete(object: post)
  }
  
  func deletePosts() {
    cacheAdapter.clear()
  }
  
  func updateFavoriteStatus(id: Int, isFavorite: Bool) {
    cacheAdapter.markPostAsFavorite(withId: id, isFavorite: isFavorite)
  }
  
  func markAsRead(id: Int) {
    cacheAdapter.markPostAsRead(withId: id, isRead: true)
  }
}

private extension PostService {
  func retrieveFromCache() -> [Post] {
    let posts = cacheAdapter.retrievePosts()
    return posts
  }
  
  func fetchFromService(withSuccess success: @escaping ([Post]) -> (), failure: @escaping Failure) throws {
    do {
      try networkAdapter.executeRequest(withPath: .posts, withSuccess: { data in
        guard let data = data else {
          failure(NetworkError.invalidData)
          return
        }
        do {
          let posts = try JSONDecoder().decode([Post].self, from: data)
          self.markPostsAsUnread(posts)
          self.cacheAdapter.save(posts)
          success(posts)
        } catch {
          failure(NetworkError.invalidHost)
        }
        
      }, failure: failure)
    } catch let error {
      throw error
    }
    
  }
  
  func markPostsAsUnread(_ posts: [Post]) {
    for i in 0..<20 {
      posts[i].read = false
    }
  }
}
