//
//  Question.swift
//  AlGlory
//
//  Created by Comviva on 24/11/26.
//

import Foundation
import SwiftData

@Model
final class Question {
    var questionId: String
    var title: String
    var difficulty: String
    var type: String
    var topic: String
    var content: ContentClass
    var expectedComplexity: ExpectedComplexity
    var hints: [String]
    var explanation: String
    var tags: [String]
    var schemaVersion: Int
    var isActive: Bool
    
    init(questionId: String, title: String, difficulty: String, type: String, topic: String, content: ContentClass, expectedComplexity: ExpectedComplexity, hints: [String], explanation: String, tags: [String], schemaVersion: Int, isActive: Bool) {
        self.questionId = questionId
        self.title = title
        self.difficulty = difficulty
        self.type = type
        self.topic = topic
        self.content = content
        self.expectedComplexity = expectedComplexity
        self.hints = hints
        self.explanation = explanation
        self.tags = tags
        self.schemaVersion = schemaVersion
        self.isActive = isActive
    }
}


struct ContentClass: Codable {
    var statement: String
    var examples: [Example]
    
    init(statement: String, examples: [Example]) {
        self.statement = statement
        self.examples = examples
    }
}

struct Example: Codable {
    var input: String
    var output: String
    var explanation: String
    var constraints: [String]
    
    init(input: String, output: String, explanation: String, constraints: [String]) {
        self.input = input
        self.output = output
        self.explanation = explanation
        self.constraints = constraints
    }
}

struct ExpectedComplexity: Codable {
    var time: String
    var space: String
    
    init(time: String, space: String) {
        self.time = time
        self.space = space
    }
}
