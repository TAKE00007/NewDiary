//
//  ListView.swift
//  NewDiray
//
//  Created by 大竹駿 on 2025/06/22.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                CardView()
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
    ListView()
}
