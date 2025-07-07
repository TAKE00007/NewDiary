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
    @Query(sort: \Diary.date, order: .reverse) private var diaries: [Diary]
    
//    @State private var diaries: [Diary] = getMockDiaries()
    @State private var returnIndex: [Int] = []
    @State private var cardOffsets: [CGSize] = []
    
    //_を前につけることでStateプロパティラッパーのインスタンスそのものを初期化することができる
    //Array(repeating: .zero, count: N)で.zero(CGSize(width: 0, height: 0)をN回繰り返して新しい配列を作成する
    //[TODO] 新規追加した際にも対応できるようにする
//    init() {
//        _cardOffsets = State(initialValue: Array(repeating: .zero, count: getMockDiaries().count))
//    }
    
//    @State private var diaries: [Diary] = [] {
//        didSet {
//            if cardOffsets.count < diaries.count {
//                let diff = diaries.count - cardOffsets.count
//                cardOffsets.append(contentsOf: Array(repeating: .zero, count: diff))
//            } else if cardOffsets.count > diaries.count {
//                cardOffsets.removeLast(cardOffsets.count - diaries.count)
//            }
//        }
//    }
    
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
                print("🧮 diaries.count: \(diaries.count)")
                print("🧮 cardOffsets.count: \(cardOffsets.count)")
                
                if cardOffsets.count != diaries.count {
                    cardOffsets = Array(repeating: .zero, count: diaries.count)
                    print("✅ cardOffsets 初期化完了: \(cardOffsets.count)")
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
            
            // TODO あとでSwiftDataに対応させる
//            NavigationLink(destination: RegisterView(diaries: $diaries)) {
//                Image(systemName: "plus.circle.fill")
//                    .resizable()
//                    .frame(width: 60, height: 60)
//                    .padding(.top, 20)
//            }
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
