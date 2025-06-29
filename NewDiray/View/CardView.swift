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
                .fill(instagramGradient)
                .frame(width: 350, height: 500)
            VStack {
                Text(diary.title)
                    .foregroundStyle(Color.white)
                    .font(.title)
                    .padding(10)
                Text(diary.text)
                    .foregroundStyle(Color.white)
                    .font(.body)
                    .padding(10)
            }
        }
        .frame(width: 350, height: 500)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.white, lineWidth: 5)
        )
        .offset(offset)
        .gesture(
            DragGesture()
                .onChanged{ value in
                    let width = value.translation.width
                    let height = value.translation.height
                    var screenWidth: CGFloat {
                        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return 0.0 }
                        return window.screen.bounds.width
                    }
                    
                    
                    if (abs(width) > 50) {
                        withAnimation {
                            offset = CGSize(width: width > 50 ? screenWidth * 1.0: screenWidth * -1.0, height: height)
                        }
                    } else {
                        offset = CGSize(width: width, height: height)
                    }
                    
                }
            //                .onEnded{ _ in
            //                    withAnimation {
            //                        offset = .zero
            //                    }
            //                }
        )
    }
        
    private var instagramGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 0.988, green: 0.376, blue: 0.482), // ピンク
                Color(red: 0.988, green: 0.776, blue: 0.294), // オレンジ
                Color(red: 0.176, green: 0.498, blue: 0.996), // 青
                Color(red: 0.647, green: 0.176, blue: 0.996)  // 紫
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

#Preview {
    CardView(diary: Diary.MOCK_DIARY1)
}
