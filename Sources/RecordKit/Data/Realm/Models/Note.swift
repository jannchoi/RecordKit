//
//  File.swift
//  RecordKit
//
//  Created by 최정안 on 4/10/25.
//

import Foundation
import RealmSwift

class Note: Object {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var date: Date?
    @Persisted var note: String

    convenience init(date: Date, note: String) {
        self.init()
        self.date = date
        self.note = note
    }
}
