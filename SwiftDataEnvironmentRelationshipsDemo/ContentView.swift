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
      Text("Updating the subitem in this view works")
      HStack {
        Text(String(subItem.value))
        Button("Toggle") {
          subItem.value.toggle()
        }
      }.padding(.bottom)
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
    VStack {
      Text("This is the subitem value via the environment. It doesn't update.")
      HStack {
        Text(String(subItem.value))
        Button("Toggle") {
          subItem.value.toggle()
        }
      }.padding(.bottom)
      Text("This is the main item via the environment. It updates fine.")
      HStack {
        Text("\(item.timestamp, format: Date.FormatStyle(date: .complete, time: .complete))")
        Button("Update") {
          item.timestamp = Date()
        }
      }.padding(.bottom)
    }
  }
}

#Preview {
  ContentView()
}
