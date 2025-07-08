//
//  CardRowView.swift
//  NewDiray
//
//  Created by 大竹駿 on 2025/06/30.
//

import SwiftUI

struct CardRowView: View {
    let diary: Diary
    let index: Int
    @Binding var returnIndex: [Int]
    @Binding var offset: CGSize
    
    
    var body: some View {
        CardView(diary: diary,
                 index: index,
                 returnIndex: $returnIndex,
                 offset: $offset)
        .offset(y: CGFloat(index) * 20)
        
    }
}

#Preview {
    CardRowView(diary: Diary.MOCK_DIARY1, index: 0, returnIndex: .constant([]), offset: .constant(.zero))
}
