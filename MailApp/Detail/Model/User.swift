//
//  User.swift
//  MailApp
//
//  Created by Santiago Avila Arroyave on 2/23/19.
//  Copyright © 2019 Santiago Avila Arroyave. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class User: Object, Codable {
  
  dynamic var id: Int
  dynamic var name: String
  dynamic var email: String
  dynamic var phone: String
  dynamic var website: String
  
}

