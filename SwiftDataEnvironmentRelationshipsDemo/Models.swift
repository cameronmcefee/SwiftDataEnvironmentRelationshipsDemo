//
//  Item.swift
//  SwiftDataEnvironmentRelationshipsDemo
//
//  Created by Cameron McEfee on 9/1/23.
//

import SwiftData
import SwiftUI

@Model
class Item {
  var timestamp = Date()

  @Relationship(deleteRule: .cascade)
  var subItems: [SubItem] = []

  init() {}
}

@Model
class SubItem {
  var value: Bool = true

  init() {}
}
