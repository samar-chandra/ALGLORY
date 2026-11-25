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
    let questionService: QuestionService
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                if missionsLocal.isEmpty {
                    Text("No missions available")
                }else{
                    ScrollView {
                        ForEach(missionsLocal, id: \.id) { mission in
                            MissionsCardView(mission: mission)
                        }
                    }
                }
            }.task {
                await syncMissions()
                await syncQuestions()
                await fetchMissions()
            }
        }
    }
    
    @MainActor
    func fetchMissions() async {
        do {
            let missions = try modelContext.fetch(FetchDescriptor<Mission>())
            self.missionsLocal = missions
        } catch {
            dump("Unable to fetch missions \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func syncMissions() async {
        var currentMissionRemoteVersion = UserDefaults.standard.integer(forKey: "remoteVersion")
        do {
            let remoteVersion = try await FetchConfig.fetchMissionVersion()
            if remoteVersion <= currentMissionRemoteVersion {
                return
            }else{
                currentMissionRemoteVersion = remoteVersion
            }
        } catch {
            print("Configuration fetch failed: \(error.localizedDescription)")
        }
        
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
                
            let localMission = Mission(schemaVersion: mission.schemaVersion, id: UUID(), title: mission.title, details: mission.details, completionStatus: .notStarted, createdAt: mission.createdAt, updatedAt: mission.createdAt, difficulty: missionDifficulty, questionIds: mission.questionIDs)
            
            self.modelContext.insert(localMission)
        }
        do {
            try self.modelContext.save()
            UserDefaults.standard.set(currentMissionRemoteVersion, forKey: "remoteVersion")
        } catch {
            dump("Could not save to local \(error.localizedDescription)")
        }
    }
    @MainActor
    func syncQuestions() async {
        var currentRemoteQuestionVersion = UserDefaults.standard.integer(forKey: "questionVersion")
        var questionsLocal: [QuestionFB] = []
        do {
            let remoteVersion = try await FetchConfig.fetchQuestionVersion()
            if remoteVersion <= currentRemoteQuestionVersion {
                return
            }else{
                currentRemoteQuestionVersion = remoteVersion
            }
        } catch {
            print("Configuration fetch failed: \(error.localizedDescription)")
        }
        
        do {
            questionsLocal =
            try await self.questionService.fetchQuestions()
            
        } catch {
            dump("Something went wrong \(error.localizedDescription)")
        }
        
        for question in questionsLocal {
            let localQuestion = Question(questionId: question.documentID ?? "", title: question.title ?? "", difficulty: question.difficulty ?? "", type: question.type ?? "", topic: question.topic ?? "", content: ContentClass(statement: question.content?.statement ?? "", examples: []), expectedComplexity: ExpectedComplexity(time: question.expectedComplexity?.time ?? "", space: question.expectedComplexity?.space ?? ""), hints: [], explanation: question.explanation ?? "", tags: [], schemaVersion: question.schemaVersion ?? 0, isActive: question.isActive ?? true)
            
            self.modelContext.insert(localQuestion)
        }
        
        do {
            try self.modelContext.save()
            UserDefaults.standard.set(currentRemoteQuestionVersion, forKey: "questionVersion")
        } catch {
            dump("Could not save to local \(error.localizedDescription)")
        }
        
        do {
            let savedQuestions = try modelContext.fetch(
                FetchDescriptor<Question>()
            )
            
            print("Same context fetch:", savedQuestions.count)
        }catch{
            
        }
    }
    }




#Preview {
    ContentView(missionService: MissionService(), questionService: QuestionService())
}
