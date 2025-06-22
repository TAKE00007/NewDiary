//
//  CardView.swift
//  NewDiray
//
//  Created by 大竹駿 on 2025/06/22.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        VStack {
            Text("タイトル")
                .font(.title)
                .padding(10)
            Text("おはよう。今日は早起きして散歩に出かけた。朝の空気はひんやりとしていてとても気持ちが良かった。")
                .font(.body)
                .padding(10)
            Text("写真")
        }
    }
}

#Preview {
    CardView()
}
