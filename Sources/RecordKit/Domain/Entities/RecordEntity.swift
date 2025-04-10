//
//  RecordEntity.swift
//  RecordKit
//
//  Created by 최정안 on 4/10/25.
//

import Foundation
public struct RecordEntity {
    public var id: String
    public var metaData: MetadataEntity
    public var detail: DetailEntity
    public var beforeRecord: NoteEntity?
    public var inProgressRecord: [ProgressNoteEntity]
    public var afterRecord: NoteEntity?

    public init(
        id: String = UUID().uuidString,
        metaData: MetadataEntity,
        detail: DetailEntity,
        beforeRecord: NoteEntity?,
        inProgressRecord: [ProgressNoteEntity],
        afterRecord: NoteEntity?
    ) {
        self.id = id
        self.metaData = metaData
        self.detail = detail
        self.beforeRecord = beforeRecord
        self.inProgressRecord = inProgressRecord
        self.afterRecord = afterRecord
    }
}


