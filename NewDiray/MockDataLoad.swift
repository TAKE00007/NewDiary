//
//  MockDataLoad.swift
//  NewDiray
//
//  Created by 大竹駿 on 2025/07/06.
//

import Foundation
import SwiftData

//JSONデータをSwiftDataにロードするヘルパ関数
//ModelContext: データベースとの主要なインターフェース：追加、削除などこのModelContextを通して行う
func loadInitialData(modelContext: ModelContext) {
    //ユーザーデフォルトを使って初回起動時のみ実行されるように制御
    //UserDefaoults: アプリケーションの設定情報や小さなデータを保存・読み込みするための仕組み
    //保存されたデータはアプリを閉じてもデバイスに残る
    // 様々なデータ型が保存でき、アクセスするときはUserDefaults.standardを使う
    // 初期データが既にデータベースにロードされたかどうかを示すフラグ
    // UserDefaultsから"hasLoadedInitialData"というキーに対応するBool値を読み込んでいる+作成している
    let defaults = UserDefaults.standard
    let hasLoadedInitialData = defaults.bool(forKey: "hasLoadedInitialData")
    
    // Bundle: アプリケーションの実行可能コードと、それに関連するリソースをまとめて格納しているディレクトリ構造
    // Xcodeプロジェクトに「MockDiaries.json」というファイルを追加した場合、ビルド時にそのファイルはアプリのバンドル内にコピーされる
    // Bundle.main: 現在実行中のアプリケーションのメインバンドルを指す
    
    if !hasLoadedInitialData {
        if let url = Bundle.main.url(forResource: "MockDiaries", withExtension: "json") {
            do {
                //Data型(バイト列)として読み込む
                //JSONをデコードする前の生データ
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                
                decoder.dateDecodingStrategy = .iso8601
//                decoder.dateDecodingStrategy = .formatted(DateFormatter.diaryDateFormatter)
                //TODO: なぜ[Diary]ではダメで[Diary].selfなのか？
                //[Diary]であるとDiaryの配列というデータ型ですと伝える
                //[Diary:.selfであるとDiaryの配列という型そのものの情報（つまり型ではなく値)
                //[Diary].self: Diary型の配列そのものを表す←JSONデータをこの型に変換しようとしている
                // dataとして与えられたJSONから[Diary]のインスタンスを生成している
                let diaries = try decoder.decode([Diary].self, from: data)
                
                for diary in diaries {
                    //同じidの日記がすでに存在しないか確認して追加
                    // TODO: $0.idというのはデータベース内の全てのidを示しているのか？データベース内にidが1,2,3,4とあった場合に順番に$0.idに代入されて比較しているということか？
                    //Predicate: データをフィルタリングする(コンパイル時にチェックが行われるため、タイプミスや不正なプロパティ名があった場合はすぐにエラーがわかる)
                    //#Predicate<Diary>はDiaryモデルに対する述語を定義するという意味
                    //データベース内に今処理しているdiaryと同じidを持つDiaryオブジェクトがあるかどうかを検索するための条件を定義している
                    //FetchDescriptor: データベースからデータをどのように取得するかを定義するためのオブジェクト
                    //どのようなモデルで取得するか？どのような条件でフィルタリングするか(predicate)?どのような順序で並び替えるか?(sortDescription)
                    // 今回はpredicateで指定した条件
                    //modelContext.fetch: descriptorに基づいてデータベースから実際にデータを取得する
                    let predicate = #Predicate<Diary> { $0.id == diary.id }
                    let descriptor = FetchDescriptor(predicate: predicate)
                    let existingDiaries = try modelContext.fetch(descriptor)
                    
                    if existingDiaries.isEmpty {
                        modelContext.insert(diary)
                    }
                }
                try modelContext.save()
                defaults.set(true, forKey: "hasLoadedInitialData")
                print("Mock data loaded successfully into SwiftData")
            } catch {
                print("Failed to load or decode mock data: \(error)")
            }
        } else {
            print("MockDiaries.json not found in main bundle.")
        }
    }
}
