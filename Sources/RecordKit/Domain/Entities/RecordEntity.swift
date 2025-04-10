//
//  RecordEntity.swift
//  RecordKit
//
//  Created by 최정안 on 4/10/25.
//

import Foundation
public struct RecordEntity {
    var id: String = UUID().uuidString
    var metaData : MetadataEntity
    var detail: DetailEntity
    var beforeRecord: NoteEntity?
    var inProgressRecord: [ProgressNoteEntity]
    var afterRecord: NoteEntity?
}

