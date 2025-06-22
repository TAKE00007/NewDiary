//
//  CardView.swift
//  NewDiray
//
//  Created by 大竹駿 on 2025/06/22.
//

import SwiftUI

struct CardView: View {
    
    let diary: Diary
    @State private var offset: CGSize = .zero
    
    var body: some View {
        ZStack {
            //backgound
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.gray)
                .frame(width: 350, height: 500)
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
        .frame(width: 350, height: 500)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.black, lineWidth: 5)
        )
        .offset(offset)
        .gesture(
            DragGesture()
                .onChanged{ gesture in
                    offset = gesture.translation
                }
                .onEnded{ _ in
                    withAnimation {
                        offset = .zero
                    }
                }
        )
    }
}

#Preview {
    CardView(diary: Diary.MOCK_DIARY1)
}
