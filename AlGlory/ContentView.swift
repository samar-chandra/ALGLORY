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
    @State private var missionsLocal: [Mission] = []
    let missionService: MissionService
    var body: some View {
        VStack(alignment: .leading) {
            if missions.isEmpty {
                
            }else{
                ScrollView {
                    ForEach(missionsLocal, id: \.title) { mission in
                        MissionsCardView(mission: mission)
                    }
                }
            }
        }.task {
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
        for mission in missions {
            var missionDifficulty: Difficulty = .easy
            if mission.difficulty == "medium"{
                missionDifficulty = .medium
            }else if mission.difficulty == "hard"{
                missionDifficulty = .hard
            }
                
            let localMission = Mission(schemaVersion: mission.schemaVersion, id: UUID(), title: mission.title, details: mission.details, completionStatus: .notStarted, createdAt: mission.createdAt, updatedAt: mission.createdAt, difficulty: missionDifficulty)
            
            self.modelContext.insert(localMission)
        }
        do {
            try self.modelContext.save()
        } catch {
            dump("Could not save to local \(error.localizedDescription)")
        }
        do {
            let missions = try modelContext.fetch(FetchDescriptor<Mission>())
            self.missionsLocal = missions
        } catch {
            dump("Unable to fetch missions \(error.localizedDescription)")
        }
    }
    }

#Preview {
    ContentView(missionService: MissionService())
}
