//
//  ContentView.swift
//  SwiftDataEnvironmentRelationshipsDemo
//
//  Created by Cameron McEfee on 9/1/23.
//

import SwiftData
import SwiftUI

struct ContentView: View {
  @Query private var items: [Item]

  var item: Item {
    guard let item = items.first else {
      fatalError("No Item")
    }
    return item
  }

  var subItem: SubItem {
    guard let subItem = item.subItems.first else {
      fatalError("No SubItem")
    }

    return subItem
  }

  // In this view the relationship item comes from the query. Toggling the value
  // updates the view as expected.
  var body: some View {
    VStack {
      Text("This one works")
      HStack {
        Text(String(subItem.value))
        Button("Toggle") {
          subItem.value.toggle()
        }
      }
      Text("This one does not")
      ChildView()
        .environment(item)
    }
  }
}

struct ChildView: View {
  @Environment(Item.self) private var item

  var subItem: SubItem {
    guard let subItem = item.subItems.first else {
      fatalError("No SubItem")
    }

    return subItem
  }

  // In this view, the relationship item comes in via the environment. Toggling
  // the value does not update *this* instance of the view, but the parent view
  // where the item comes from the query does update.
  var body: some View {
    HStack {
      Text(String(subItem.value))
      Button("Toggle") {
        subItem.value.toggle()
      }
    }
  }
}

#Preview {
  ContentView()
}
