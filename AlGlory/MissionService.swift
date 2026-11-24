//
//  MissionService.swift
//  AlGlory
//
//  Created by Comviva on 24/11/26.
//

import Foundation
import FirebaseFirestore

final class MissionService {
    func fetchMissions() async throws -> [MissionFB]{
        let snapshot = try await Firestore.firestore()
            .collection("missions")
            .getDocuments()
        var missions: [MissionFB] = []
        for document in snapshot.documents {
            let mission = try document.data(as: MissionFB.self)
            missions.append(mission)
        }
        return missions
    }
}
