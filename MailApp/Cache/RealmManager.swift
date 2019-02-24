//
//  RealmManager.swift
//  MailApp
//
//  Created by Santiago Avila Arroyave on 2/23/19.
//  Copyright © 2019 Santiago Avila Arroyave. All rights reserved.
//

import Foundation
import RealmSwift

protocol PersistenceMechanism {
  func clear()
  func save<T>(object: T)
  func save<T>(objects: [T])
  func delete<T>(object: T)
  func retrievePosts() -> [Post]
  func retrieveUser(withId id: Int) -> User?
  func markPostAsRead(withId id: Int, isRead: Bool)
  func markPostAsFavorite(withId id: Int, isFavorite: Bool)
}

class RealManager: PersistenceMechanism {
  
  let realm: Realm
  
  init() {
    realm = try! Realm()
  }
  
  func clear() {
    try! realm.write {
      realm.deleteAll()
    }
  }
  
  func save<T>(object: T) {
    try! realm.write {
      realm.add(object as! Object)
    }
  }
  
  func save<T>(objects: [T]) {
    try! realm.write {
      realm.add(objects as! [Object])
    }
  }
  
  func delete<T>(object: T) {
    try! realm.write {
      realm.delete(object as! Object)
    }
  }
  
  func retrievePosts() -> [Post] {
    return Array(realm.objects(Post.self))
  }
  
  func retrieveUser(withId id: Int) -> User? {
    return realm.objects(User.self).first(where: { $0.id == id })
  }
  
  func markPostAsFavorite(withId id: Int, isFavorite: Bool) {
    let post = realm.objects(Post.self).first(where: { $0.id == id })
    try! realm.write {
      post?.favorite = isFavorite
    }
  }
  
  func markPostAsRead(withId id: Int, isRead: Bool) {
    let posts = realm.objects(Post.self).filter("id = %d", id)
    if let post = posts.first {
      try! realm.write {
        post.read = isRead
      }
    }
  }

}
