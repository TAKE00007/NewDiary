//
//  RegesterView.swift
//  NewDiray
//
//  Created by 大竹駿 on 2025/06/22.
//

import SwiftUI

struct RegisterView: View {
    
//    var diary: Diary
    
    @State private var title = ""
    @State private var text = ""
    
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("タイトルを入力", text: $title)
                TextEditor(text: $text)
                    .frame(minHeight: 200)
                    .padding(4)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                Button("保存") {
                        print("ボタンが押されました")
                }
            }
            .padding()
        }
    }
}

#Preview {
    RegisterView()
}
