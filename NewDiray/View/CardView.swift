//
//  CardView.swift
//  NewDiray
//
//  Created by 大竹駿 on 2025/06/22.
//

import SwiftUI

struct CardView: View {
    
    let diary: Diary
    
    var body: some View {
        VStack {
            Text(diary.title)
                .font(.title)
                .padding(10)
            Text(diary.text)
                .font(.body)
                .padding(10)
            Text("写真")
        }
    }
}

#Preview {
    CardView(diary: Diary.MOCK_DIARY1)
}
