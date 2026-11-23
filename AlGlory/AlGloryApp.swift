//
//  AlGloryApp.swift
//  AlGlory
//
//  Created by Comviva on 23/11/26.
//

import SwiftUI
import SwiftData

@main
struct AlGloryApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Mission.self
        ])
        do {
            let container = try ModelContainer(for: schema)
            return container
        }catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
        
    }
}
