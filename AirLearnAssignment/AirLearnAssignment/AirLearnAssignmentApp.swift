//
//  AirLearnAssignmentApp.swift
//  AirLearnAssignment
//
//  Created by Aakash Narkar on 08/08/25.
//

import SwiftUI

@main
struct AirLearnAssignmentApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
