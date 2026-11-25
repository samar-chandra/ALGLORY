//
//  QuestionsView.swift
//  AlGlory
//
//  Created by Comviva on 24/11/26.
//

import SwiftUI
import SwiftData

struct QuestionsView: View {
    @Environment(\.modelContext) var modelContext
    var questionTags: [String]
    @State var questionsLocal: [Question] = []
    var body: some View {
        VStack {
            ScrollView {
                ForEach(questionsLocal,id: \.self) { localQuestion in
                    QuestionCard(question: localQuestion)
                }
            }
        }.task {
            self.fetchAppropriateQuestions()
        }
    }
    
    func fetchAppropriateQuestions() {
        do {
            let questions = try modelContext.fetch(FetchDescriptor<Question>())
            self.questionsLocal = questions.filter({self.questionTags.contains($0.questionId)})
            dump(questionsLocal.count)
        } catch {
            dump("Unable to fetch missions \(error.localizedDescription)")
        }
    }
}

#Preview {
    QuestionsView(questionTags: ["q0001","q0002"])
}
