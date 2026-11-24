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
    @State private var missions: [MissionFB] = []
    let missionService: MissionService
    var body: some View {
        ForEach(missions, id: \.title) { mission in
            Text(mission.title)
        }
        Text("Welcome to ALGlory")
            .task {
                        await getMissions()
                    }
    }
    
    func getMissions() async {
        do {
            self.missions =
            try await self.missionService.fetchMissions()
        } catch {
            dump("Something went wrong \(error.localizedDescription)")
        }
    }
    }

#Preview {
    ContentView(missionService: MissionService())
}
