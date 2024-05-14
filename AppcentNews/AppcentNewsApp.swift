//
//  AppcentNewsApp.swift
//  AppcentNews
//
//  Created by oguzhan on 14.05.2024.
//

import SwiftUI

@main
struct AppcentNewsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
