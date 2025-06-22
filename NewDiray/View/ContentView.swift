//
//  ContentView.swift
//  NewDiray
//
//  Created by 大竹駿 on 2025/06/22.
//

import SwiftUI

struct ContentView: View {
    
    let diary: Diary = Diary.MOCK_DIARY1
    
    var body: some View {
        ListView(diary: diary)
    }
}

#Preview {
    ContentView()
}
