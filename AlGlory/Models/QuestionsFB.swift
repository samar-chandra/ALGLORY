//
//  QuestionsFB.swift
//  AlGlory
//
//  Created by Comviva on 24/11/26.
//

import Foundation
import FirebaseFirestore

struct QuestionFB: Codable {
    var documentID: String?
    var title: String?
    var difficulty: String?
    var type: String?
    var topic: String?
    var content: ContentFB?
    var expectedComplexity: ExpectedComplexityFB?
    var hints: [String]?
    var explanation: String?
    var tags: [String]?
    var schemaVersion: Int?
    var isActive: Bool?
    
    enum CodingKeys: CodingKey {
        case documentID
        case title
        case difficulty
        case type
        case topic
        case content
        case expectedComplexity
        case hints
        case explanation
        case tags
        case schemaVersion
        case isActive
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.documentID = try container.decodeIfPresent(String.self, forKey: .documentID)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.difficulty = try container.decodeIfPresent(String.self, forKey: .difficulty)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.topic = try container.decodeIfPresent(String.self, forKey: .topic)
        self.content = try container.decodeIfPresent(ContentFB.self, forKey: .content)
        self.expectedComplexity = try container.decodeIfPresent(ExpectedComplexityFB.self, forKey: .expectedComplexity)
        self.hints = try container.decodeIfPresent([String].self, forKey: .hints)
        self.explanation = try container.decodeIfPresent(String.self, forKey: .explanation)
        self.tags = try container.decodeIfPresent([String].self, forKey: .tags)
        self.schemaVersion = try container.decodeIfPresent(Int.self, forKey: .schemaVersion)
        self.isActive = try container.decodeIfPresent(Bool.self, forKey: .isActive)
    }
}


struct ContentFB: Codable {
    var statement: String?
    var examples: [ExampleFB]?
    
    enum CodingKeys: CodingKey {
        case statement
        case examples
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.statement = try container.decodeIfPresent(String.self, forKey: .statement)
        self.examples = try container.decodeIfPresent([ExampleFB].self, forKey: .examples)
    }
    
}

struct ExampleFB: Codable {
    var input: String?
    var output: String?
    var explanation: String?
    var constraints: [String]?
    
    enum CodingKeys: CodingKey {
        case input
        case output
        case explanation
        case constraints
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.input = try container.decodeIfPresent(String.self, forKey: .input)
        self.output = try container.decodeIfPresent(String.self, forKey: .output)
        self.explanation = try container.decodeIfPresent(String.self, forKey: .explanation)
        self.constraints = try container.decodeIfPresent([String].self, forKey: .constraints)
    }
}

struct ExpectedComplexityFB: Codable {
    var time: String?
    var space: String?
    
    enum CodingKeys: CodingKey {
        case time
        case space
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.time = try container.decodeIfPresent(String.self, forKey: .time)
        self.space = try container.decodeIfPresent(String.self, forKey: .space)
    }
}
