//
//  CacheManager.swift
//  MailApp
//
//  Created by Santiago Avila Arroyave on 2/22/19.
//  Copyright © 2019 Santiago Avila Arroyave. All rights reserved.
//

import Foundation
import CoreData

class CacheAdapter {
  
  private let persistenceMechanism: PersistenceMechanism
  
  init(persistenceMechanism: PersistenceMechanism = RealManager()) {
    self.persistenceMechanism = persistenceMechanism
  }
  
  func save<T>(_ object: T) {
    persistenceMechanism.save(object: object)
  }
  
  func save<T>(_ objects: [T]) {
    persistenceMechanism.save(objects: objects)
  }
  
  func retrievePosts() -> [Post] {
    return persistenceMechanism.retrievePosts()
  }
  
  func retrieveUser(withId id: Int) -> User? {
    return persistenceMechanism.retrieveUser(withId: id)
  }
  
  func clear() {
    persistenceMechanism.clear()
  }
  
  func delete<T>(object: T) {
    persistenceMechanism.delete(object: object)
  }
  
  func markPostAsRead(withId id: Int, isRead: Bool) {
    persistenceMechanism.markPostAsRead(withId: id, isRead: isRead)
  }
  
  func markPostAsFavorite(withId id: Int, isFavorite: Bool) {
    persistenceMechanism.markPostAsFavorite(withId: id, isFavorite: isFavorite)
  }
}
