//
//  NewDirayApp.swift
//  NewDiray
//
//  Created by 大竹駿 on 2025/06/22.
//

import SwiftUI
import SwiftData

@main
struct NewDirayApp: App {
    // TODO: ここで何をしているのか
    @State private var container = try! ModelContainer(for: Diary.self)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(container)
                .onAppear {
                    loadInitialData(modelContext: container.mainContext)
                }
        }
        .modelContainer(for: Diary.self)
    }
}
