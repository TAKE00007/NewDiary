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
    //Diaryモデル用のSwiftData永続コンテナを作って、ビュー内部で状態として保持する
    
    @State private var container: ModelContainer
    init() {
        do {
            container = try ModelContainer(for: Diary.self)
        } catch {
            fatalError("SwiftDataの作成に失敗しました\(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(container)
//                .onAppear {
//                    loadInitialData(modelContext: container.mainContext)
//                }
        }
        .modelContainer(for: Diary.self)
    }
}
