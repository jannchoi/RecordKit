//
//  File.swift
//  RecordKit
//
//  Created by 최정안 on 4/10/25.
//

import Foundation
import RealmSwift

class ProgressNote: Object {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var startPage: Int?
    @Persisted var endPage: Int?
    @Persisted var date: Date?
    @Persisted var note: String

    convenience init(startPage: Int, endPage: Int, date: Date, note: String) {
        self.init()
        self.startPage = startPage
        self.endPage = endPage
        self.date = date
        self.note = note
    }
}
