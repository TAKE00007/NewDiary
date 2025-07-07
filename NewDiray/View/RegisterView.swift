//
//  RegesterView.swift
//  NewDiray
//
//  Created by 大竹駿 on 2025/06/22.
//

import SwiftUI
import SwiftData

struct RegisterView: View {
    
    @Environment(\.modelContext) private var context
    @Query private var diaries: [Diary]
    
//    @Binding var diaries: [Diary]
    
    @State private var title = ""
    @State private var text = ""
    
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("タイトルを入力", text: $title)
                TextEditor(text: $text)
                    .frame(minHeight: 200)
                    .padding(4)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            
                
                Button {
                    let newDiary = Diary(
                        id: UUID(),
                        title: title,
                        text: text,
                        date: Date()
                    )
                    context.insert(newDiary)
                    do {
                        try context.save()
                    } catch {
                        print("追加に失敗しました\(error)")
                    }
//                    diaries.append(newDiary)
                    dismiss()
                } label: {
                    Text("保存")
                }
            }
            .navigationTitle("日記登録")
            .padding()
        }
    }
}

#Preview {
    RegisterView()
        .modelContainer(for: Diary.self, inMemory: true)
}
