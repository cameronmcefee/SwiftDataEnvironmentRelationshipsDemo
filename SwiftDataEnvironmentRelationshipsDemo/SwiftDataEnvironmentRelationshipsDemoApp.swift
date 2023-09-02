//
//  SwiftDataEnvironmentRelationshipsDemoApp.swift
//  SwiftDataEnvironmentRelationshipsDemo
//
//  Created by Cameron McEfee on 9/1/23.
//

import SwiftData
import SwiftUI

struct ContainerGenerator {
  @MainActor
  static func create() -> ModelContainer {
    let schema = Schema([
      Item.self,
    ])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

    let modelContainer = try! ModelContainer(for: schema, configurations: [modelConfiguration])

    let item = Item()
    modelContainer.mainContext.insert(item)

    let subItem = SubItem()
    modelContainer.mainContext.insert(subItem)

    item.subItems.append(subItem)

    return modelContainer
  }
}

@main
struct SwiftDataEnvironmentRelationshipsDemoApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
        .modelContainer(ContainerGenerator.create())
    }
  }
}
