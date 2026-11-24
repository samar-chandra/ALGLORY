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
            let mission = try document.data(as: MissionFB.self)
            dump(mission)
        }
    }
}
