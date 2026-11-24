//
//  ContentView.swift
//  AlGlory
//
//  Created by Comviva on 23/11/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    let missionService: MissionService
    var body: some View {
        
        Text("Welcome to ALGlory")
            .task {
                        await getMissions()
                    }
    }
    
    func getMissions() async {
        do {
            try await self.missionService.fetchMissions()
        } catch {
            dump("Something went wrong \(error.localizedDescription)")
        }
    }
    }

#Preview {
    ContentView(missionService: MissionService())
}
