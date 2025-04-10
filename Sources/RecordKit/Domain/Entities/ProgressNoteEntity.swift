//
//  ProgressNoteEntity.swift
//  RecordKit
//
//  Created by 최정안 on 4/10/25.
//

import Foundation
public struct ProgressNoteEntity {
    public let id: UUID
    public let startPage: String?
    public let endPage: String?
    public let date: Date?
    public let note: String

    public init(
        id: UUID = UUID(),
        startPage: String?,
        endPage: String?,
        date: Date?,
        note: String
    ) {
        self.id = id
        self.startPage = startPage
        self.endPage = endPage
        self.date = date
        self.note = note
    }
}

