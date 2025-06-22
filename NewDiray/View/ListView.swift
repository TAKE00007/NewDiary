//
//  ListView.swift
//  NewDiray
//
//  Created by 大竹駿 on 2025/06/22.
//

import SwiftUI

struct ListView: View {
    
    let diary: Diary
    
    var body: some View {
        NavigationStack {
            ZStack {
                CardView(diary: Diary.MOCK_DIARY1)
            }
            .navigationTitle("Diary")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Text("2025/06/22")
                }
            }
        }
    }
}

#Preview {
    ListView(diary: Diary.MOCK_DIARY1)
}
