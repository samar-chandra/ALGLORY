//
//  MissionService.swift
//  AlGlory
//
//  Created by Comviva on 24/11/26.
//

import Foundation
import FirebaseFirestore

final class MissionService {
    func fetchMissions() async throws {
        let snapshot = try await Firestore.firestore()
            .collection("missions")
            .getDocuments()
        var missions: [String: MissionFB] = [:]
        for document in snapshot.documents {
            missions[document.documentID] = MissionFB(title: document["title"] as? String, details: <#T##String#>, difficulty: <#T##String#>, questionIDs: <#T##[String]#>, createdAt: <#T##Date#>, updatedAt: <#T##Date#>, learningObjectives: <#T##[String]#>, schemaVersion: <#T##Int#>, isActive: <#T##Bool#>)
        }
    }
}
