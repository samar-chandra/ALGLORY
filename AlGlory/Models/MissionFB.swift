//
//  Questions.swift
//  AlGlory
//
//  Created by Comviva on 24/11/26.
//

import Foundation

struct MissionFB: Codable {
    var title: String
    var details: String
    var difficulty: String
    var questionIDs: [String]
    var createdAt: Date
    var updatedAt: Date
    var learningObjectives: [String]
    var schemaVersion: Int
    var isActive: Bool
}
