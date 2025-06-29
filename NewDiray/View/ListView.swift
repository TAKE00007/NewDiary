//
//  ListView.swift
//  NewDiray
//
//  Created by 大竹駿 on 2025/06/22.
//

import SwiftUI

struct ListView: View {
    
    @State private var diaries: [Diary] = getMockDiaries()
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                ForEach(diaries.indices, id: \.self){ index in
                    CardView(diary: diaries[index])
                        .offset(y: CGFloat(index) * 20)
                }
                
                VStack {
                    
                    Spacer()
                    
                    NavigationLink(destination: RegisterView(diaries: $diaries)) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                    }
                }
                

            }
            .navigationTitle("Diary")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    //現在月に直す
                    let now = Date()
                    Text(DateFormatter.diaryDateFormatter.string(from: now))
                }
            }
        }
    }
}

#Preview {
    ListView()
}

func getMockDiaries() -> [Diary] {
    return [
        Diary.MOCK_DIARY1,
        Diary.MOCK_DIARY2,
        Diary.MOCK_DIARY3,
        Diary.MOCK_DIARY4,
        Diary.MOCK_DIARY5,
        Diary.MOCK_DIARY6,
        Diary.MOCK_DIARY7,
        Diary.MOCK_DIARY8,
        Diary.MOCK_DIARY9,
        Diary.MOCK_DIARY10
    ]
}
