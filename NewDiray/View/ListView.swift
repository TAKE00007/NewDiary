//
//  ListView.swift
//  NewDiray
//
//  Created by 大竹駿 on 2025/06/22.
//

import SwiftUI

struct ListView: View {
    
    @State private var diaries: [Diary] = getMockDiaries()
    @State private var returnIndex: [Int] = []
    @State private var cardOffsets: [CGSize]
    
    //_を前につけることでStateプロパティラッパーのインスタンスそのものを初期化することができる
    //Array(repeating: .zero, count: N)で.zero(CGSize(width: 0, height: 0)をN回繰り返して新しい配列を作成する
    //[TODO] 新規追加した際にも対応できるようにする
    init() {
        _cardOffsets = State(initialValue: Array(repeating: .zero, count: getMockDiaries().count))
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                ForEach(diaries.indices, id: \.self){ index in
                    CardRowView(diary: diaries[index],
                                index: index,
                                returnIndex: $returnIndex,
                                offset: $cardOffsets[index])
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
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        returnCard()
                    }, label: {
                        Image(systemName: "arrow.trianglehead.clockwise")
                            .padding(.leading, 20)
                            .foregroundStyle(Color.blue)
                    })
                }
            }
            
            Spacer()
            
            NavigationLink(destination: RegisterView(diaries: $diaries)) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .padding(.top, 20)
            }
        }
    }
    
    private func returnCard() {
        if let indexToReturn = returnIndex.last {
            withAnimation {
                cardOffsets[indexToReturn] = .zero
            }
            returnIndex.removeLast()
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
