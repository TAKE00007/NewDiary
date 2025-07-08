//
//  ListView.swift
//  NewDiray
//
//  Created by 大竹駿 on 2025/06/22.
//

import SwiftUI
import SwiftData

struct ListView: View {
    
    @Environment(\.modelContext) private var context
    @Query(sort: \Diary.date) private var diaries: [Diary]
    
    @State private var returnIndex: [Int] = []
    @State private var cardOffsets: [CGSize] = []
    
    var body: some View {
        
        NavigationStack {
            ZStack(alignment: .top) {
                if cardOffsets.count == diaries.count {
                    ForEach(diaries.indices, id: \.self){ index in
                        CardRowView(diary: diaries[index],
                                    index: index,
                                    returnIndex: $returnIndex,
                                    offset: $cardOffsets[index])
                    }
                } else {
                    ProgressView("Loading...")
                        .padding(.top, 100)
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
            .onAppear{
                // .onAppearはviewが画面に表示される直前、または表示された直後に一度だけ実行される
                // .onAppearでcardOffsetsを初期設定
                // diariesがロードされた後にcardOffsetsを設定
                //初回ロード時やデータ変更時にcardOffsetsが正しく初期化される
                if cardOffsets.count != diaries.count {
                    cardOffsets = Array(repeating: .zero, count: diaries.count)
                }
            }
            .onChange(of: diaries.count) { oldValue, newValue in //変化前と変化後の値を取得できる
                if newValue > oldValue {
                    let diff = newValue - oldValue
                    cardOffsets.append(contentsOf: Array(repeating: .zero, count: diff))
                } else if newValue < oldValue {
                    cardOffsets = Array(repeating: .zero, count: newValue)
                }
            }
            
            Spacer()
            
            NavigationLink(destination: RegisterView()) {
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
        .modelContainer(for: Diary.self, inMemory: true)
}
