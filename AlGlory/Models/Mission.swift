//
//  Mission.swift
//  AlGlory
//
//  Created by Comviva on 23/11/26.
//

import Foundation
import SwiftData

@Model
class Mission {
    var schemaVersion:Int
    var id: UUID
    var title: String
    var details: String
    var completionStatus: CompletionStatus
    var createdAt: Date
    var updatedAt: Date
    var difficulty: Difficulty
    
    var xpReward: Int {
        switch difficulty {
        case .easy: return 100
        case .medium: return 200
        case .hard: return 300
        }
    }
    
    init(schemaVersion: Int, id: UUID, title: String, details: String, completionStatus: CompletionStatus, createdAt: Date, updatedAt: Date, difficulty: Difficulty) {
        self.schemaVersion = schemaVersion
        self.id = id
        self.title = title
        self.details = details
        self.completionStatus = completionStatus
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.difficulty = difficulty
    }
    
}

enum CompletionStatus: String, Codable {
    case notStarted
    case inProgress
    case completed
}

enum Difficulty: String, Codable {
    case easy
    case medium
    case hard
}
