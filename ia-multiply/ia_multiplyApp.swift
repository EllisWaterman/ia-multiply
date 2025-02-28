//
//  ia_multiplyApp.swift
//  ia-multiply
//
//  Created by ellis on 1/26/25.
//

import SwiftUI
import SwiftData
import CoreData


@main
struct ia_multiplyApp: App {
    let persistenceController = PersistenceController.shared
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @Environment(\.managedObjectContext) private var viewContext

    var body: some Scene {
        WindowGroup {
            let student = persistenceController.fetchStudent()
            ContentView(student: student).environment(\.managedObjectContext, persistenceController.viewContext)
        }
        .modelContainer(sharedModelContainer)
    }
}
