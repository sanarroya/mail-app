//
//  Post.swift
//  MailApp
//
//  Created by Santiago Avila Arroyave on 2/22/19.
//  Copyright © 2019 Santiago Avila Arroyave. All rights reserved.
//

import Foundation
import CoreData
import RealmSwift

@objcMembers
class Post: Object, Codable {
  
  private enum CodingKeys: String, CodingKey {
    case id
    case userId
    case title
    case body
  }
  
  dynamic var id: Int
  dynamic var userId: Int
  dynamic var title: String
  dynamic var body: String
  dynamic var read = true
  dynamic var favorite = false
  
}
