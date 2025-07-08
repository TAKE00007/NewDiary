//
//  CardView.swift
//  NewDiray
//
//  Created by 大竹駿 on 2025/06/22.
//

import SwiftUI

struct CardView: View {
    
    let diary: Diary
    let index: Int
    @Binding var returnIndex: [Int]
    @Binding var offset: CGSize
    
    var body: some View {
        ZStack {
            //backgound
            RoundedRectangle(cornerRadius: 15)
                .fill(instagramGradient)
                .frame(width: 350, height: 500)
            VStack {
                Text(diary.title)
                    .font(.title)
                    .padding(10)
        
                Text(diary.text)
                    .font(.body)
                    .padding(30)
                
                Text(DateFormatter.diaryDateFormatter.string(from: diary.date))
                    .fontWeight(.semibold)
                    .padding(.top, 40)
            }
            .foregroundStyle(Color.white)
            
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
                            if !returnIndex.contains(index) {
                                returnIndex.append(index)
                            }
                            print(returnIndex)
                        }
                    } else {
                        offset = CGSize(width: width, height: height)
                    }
                    
                }
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
    CardView(diary: Diary.MOCK_DIARY1,index: 1 ,returnIndex: .constant([]), offset: .constant(.zero))
}
