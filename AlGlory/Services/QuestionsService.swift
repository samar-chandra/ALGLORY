//
//  QuestionsService.swift
//  AlGlory
//
//  Created by Comviva on 24/11/26.
//

import Foundation
import FirebaseFirestore

final class QuestionService {
    func fetchQuestions() async throws -> [QuestionFB]{
        let snapshot = try await Firestore.firestore()
            .collection("questions")
            .getDocuments()
        var questions: [QuestionFB] = []
        for document in snapshot.documents {
            dump(document.documentID)
            var mission = try document.data(as: QuestionFB.self)
            mission.documentID = document.documentID
            questions.append(mission)
        }
        return questions
    }
}
