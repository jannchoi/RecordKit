//
//  File.swift
//  RecordKit
//
//  Created by 최정안 on 4/10/25.
//

import Foundation
protocol RecordMapperProtocol {
    func mapToDomain(realmModel: Record) -> RecordEntity
    func mapToRealm(domainModel: RecordEntity) -> Record
    func mapToDomain(note: Note) -> NoteEntity
    func mapToRealm(note: NoteEntity) -> Note
    func mapToDomain(progressNote: ProgressNote) -> ProgressNoteEntity
    func mapToRealm(progressNote: ProgressNoteEntity) -> ProgressNote
}
