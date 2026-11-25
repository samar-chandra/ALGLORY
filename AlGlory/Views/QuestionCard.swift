//
//  QuestionCard.swift
//  AlGlory
//
//  Created by Comviva on 24/11/26.
//

import SwiftUI

struct QuestionCard: View {
    var question: Question
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(question.title)
                        .font(.title)
                        .bold()
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                    Text(question.explanation)
                }
                Image("questionIcon")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
            }
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(Color.gray.opacity(0.3))
            HStack{
                Text(question.topic)
                    .font(.footnote)
                    .foregroundStyle(Color.black)
                    .padding(5)
                    .frame(alignment: .center).background {
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color.gray.opacity(0.1))
                            }
                Spacer()
                Text(question.difficulty)
                    .font(.footnote)
                    .foregroundStyle(Color.white)
                    .padding(5)
                    .frame(alignment: .center).background {
                        RoundedRectangle(cornerRadius: 24)
                            .fill(getColor(difficulty: Difficulty(rawValue: question.difficulty.lowercased()) ?? .easy))
                            }
                
                
            }
        }.padding(20)
            .frame(maxWidth: .infinity, alignment: .leading).background {
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.white)
                    .shadow(
                        color: .black.opacity(0.12),
                                radius: 12,
                                x: 0,
                                y: 6
                            )
                    }
                    .padding()
    }
    
    func getColor(difficulty: Difficulty) -> Color {
        switch difficulty {
        case .easy:
            return Color.green
        case .medium:
            return Color.yellow
        default:
            return Color.red
        }
    }
}

#Preview {
    QuestionCard(
        question: Question(
            questionId: "1",
            title: "Two Sum",
            difficulty: "Easy",
            type: "MCQ",
            topic: "Arrays",
            content: ContentClass(
                statement: "Given an array of integers, find the largest element.",
                examples: []
            ),
            expectedComplexity: ExpectedComplexity(
                time: "O(n)",
                space: "O(1)"
            ),
            hints: ["Iterate through the array while tracking the maximum."],
            explanation: "Traverse the array once and keep updating the maximum whenever a larger element is found.",
            tags: ["arrays", "basic"],
            schemaVersion: 1,
            isActive: true
        )
    )
}
