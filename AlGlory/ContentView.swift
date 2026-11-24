//
//  ContentView.swift
//  AlGlory
//
//  Created by Comviva on 23/11/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    var body: some View {
        Text("Welcome to ALGlory")
    }
    }

#Preview {
    ContentView()
}
