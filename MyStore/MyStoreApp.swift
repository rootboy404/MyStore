//
//  MyStoreApp.swift
//  MyStore
//
//  Created by Rafael Silva on 04/09/21.
//

import SwiftUI

@main
struct MyStoreApp: App {
    let persistenceController = PersistenceController.banco
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext,persistenceController.container.viewContext)
        }
    }
}
