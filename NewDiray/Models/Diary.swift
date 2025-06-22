//
//  Diary.swift
//  NewDiray
//
//  Created by 大竹駿 on 2025/06/22.
//

import Foundation

struct Diary: Identifiable {
    let id: UUID
    let title: String
    let text: String
    let date: Date
}



extension Diary {
    static let MOCK_DIARY1 = Diary(
        id: UUID(),
        title: "いつもの朝",
        text: "おはよう。今日は早起きして散歩に出かけた。朝の空気はひんやりとしていて、とても気持ちが良かった。",
        date: DateFormatter.diaryDateFormatter.date(from: "2025/02/21")!
    )

    static let MOCK_DIARY2 = Diary(
        id: UUID(),
        title: "いつもの昼",
        text: "昼ご飯にカレーを作った。久しぶりに作ったけど、意外と美味しくできたので満足。次はもっと辛くしてみよう。",
        date: DateFormatter.diaryDateFormatter.date(from: "2025/02/22")!
    )

    static let MOCK_DIARY3 = Diary(
        id: UUID(),
        title: "昼食後",
        text: "天気が良かったので公園で読書をした。鳥のさえずりを聞きながら読む本は格別。とても贅沢な時間だった。",
        date: DateFormatter.diaryDateFormatter.date(from: "2025/02/23")!
    )

    static let MOCK_DIARY4 = Diary(
        id: UUID(),
        title: "仕事終わり",
        text: "今日は仕事が忙しかったが、やりがいも感じた。集中していたら時間があっという間に過ぎて驚いた。",
        date: DateFormatter.diaryDateFormatter.date(from: "2025/02/24")!
    )

    static let MOCK_DIARY5 = Diary(
        id: UUID(),
        title: "いつもとは違う夜",
        text: "夜、友達と電話をした。最近の悩みを話せて気持ちが軽くなった。やっぱり話すことって大事だと感じた。",
        date: DateFormatter.diaryDateFormatter.date(from: "2025/02/25")!
    )

    static let MOCK_DIARY6 = Diary(
        id: UUID(),
        title: "新しい靴",
        text: "新しい靴を買った。思っていたよりも履き心地がよくて嬉しい。週末の散歩が今から楽しみになった。",
        date: DateFormatter.diaryDateFormatter.date(from: "2025/02/26")!
    )

    static let MOCK_DIARY7 = Diary(
        id: UUID(),
        title: "映画",
        text: "映画を見た。ストーリーが感動的で涙が止まらなかった。エンドロールまで見届けて、余韻に浸った。",
        date: DateFormatter.diaryDateFormatter.date(from: "2025/02/27")!
    )

    static let MOCK_DIARY8 = Diary(
        id: UUID(),
        title: "掃除",
        text: "部屋の掃除をした。久しぶりに断捨離もして気分がすっきり。次はクローゼットの整理をしようと思う。",
        date: DateFormatter.diaryDateFormatter.date(from: "2025/02/28")!
    )

    static let MOCK_DIARY9 = Diary(
        id: UUID(),
        title: "図書館",
        text: "図書館に行った。気になっていた小説を借りられて嬉しい。今夜はゆっくり読書タイムを楽しみたい。",
        date: DateFormatter.diaryDateFormatter.date(from: "2025/03/01")!
    )

    static let MOCK_DIARY10 = Diary(
        id: UUID(),
        title: "雨",
        text: "今日は雨。静かな一日だったけれど、家の中で好きな音楽を流してリラックスできた。こんな日も悪くない。",
        date: DateFormatter.diaryDateFormatter.date(from: "2025/03/02")!
    )
}

extension DateFormatter {
    static let diaryDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter
    }()
}

