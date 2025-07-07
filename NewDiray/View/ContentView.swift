//
//  ContentView.swift
//  NewDiray
//
//  Created by 大竹駿 on 2025/06/22.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
//    @State var diaries: [Diary] = getMockDiaries()
    
    var body: some View {
        ListView()
            .onAppear{
                loadInitialData(modelContext: modelContext)
            }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Diary.self)
}

