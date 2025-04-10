//
//  NoteEntity.swift
//  RecordKit
//
//  Created by 최정안 on 4/10/25.
//

import Foundation
public struct NoteEntity {
    public let id: UUID
    public let date: Date?
    public let note: String

    public init(
        id: UUID = UUID(),
        date: Date?,
        note: String
    ) {
        self.id = id
        self.date = date
        self.note = note
    }
}
