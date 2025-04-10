//
//  RecordMapper.swift
//  RecordKit
//
//  Created by 최정안 on 4/10/25.
//

import Foundation
import RealmSwift

final class RecordMapper: RecordMapperProtocol {

    func mapToDomain(realmModel: Record) -> RecordEntity {
        let recordEntity = RecordEntity(
            id: realmModel.id,
            metaData: MetadataEntity(
                title: realmModel.title,
                subtitle: realmModel.subtitle,
                addedDate: realmModel.addedDate,
                thumbnailPath: realmModel.thumbnailPath
            ),
            detail: DetailEntity(
                status: StatusEntity(rawValue: realmModel.recordStatus.rawValue) ?? .before,
                shortNote: realmModel.shortNote,
                categoryTags: Array(realmModel.categoryTags),
                feelingTags: realmModel.feelingTags.map {
                    FeelingTag(name: $0.name, colorHex: $0.colorHex, emoji: $0.emoji)
                }
            ),
            beforeRecord: realmModel.beforeNote.map { mapToDomain(note: $0) },
            inProgressRecord: realmModel.inProgressNote.map { mapToDomain(progressNote: $0) },
            afterRecord: realmModel.afterNote.map { mapToDomain(note: $0) }
        )
        return recordEntity
    }

    // MARK: - Domain → Realm
    func mapToRealm(domainModel: RecordEntity) -> Record {
        let record = Record()
        record.id = domainModel.id
        record.thumbnailPath = domainModel.metaData.thumbnailPath
        
        record.title = domainModel.metaData.title
        
        record.subtitle = domainModel.metaData.subtitle
        
        record.recordStatus = RecordStatus(rawValue: domainModel.detail.status.rawValue) ?? .before
        
        record.shortNote = domainModel.detail.shortNote
        
        record.categoryTags.removeAll()
        domainModel.detail.categoryTags.forEach {
            record.categoryTags.append($0)
        }
        
        record.feelingTags.removeAll()
        domainModel.detail.feelingTags.forEach {
            let tag = FeelingTagObject()
            tag.name = $0.name
            tag.colorHex = $0.colorHex
            tag.emoji = $0.emoji
            record.feelingTags.append(tag)
        }

        record.beforeNote = domainModel.beforeRecord.map { mapToRealm(note: $0) }
        record.inProgressNote.removeAll()
        domainModel.inProgressRecord.forEach{
            record.inProgressNote.append(mapToRealm(progressNote: $0))
        }
        record.afterNote = domainModel.afterRecord.map { mapToRealm(note: $0) }

        return record
    }
}

// MARK: - Note Mapping
extension RecordMapper {
    func mapToDomain(note: Note) -> NoteEntity {
        return NoteEntity(
            date: note.date,
            note: note.note
        )
    }

    func mapToRealm(note: NoteEntity) -> Note {
        return Note(
            date: note.date ?? Date(),
            note: note.note
        )
    }
}

// MARK: - ProgressNote Mapping
extension RecordMapper {
    func mapToDomain(progressNote: ProgressNote) -> ProgressNoteEntity {
        return ProgressNoteEntity(
            startPage: progressNote.startPage?.description,
            endPage: progressNote.endPage?.description,
            date: progressNote.date,
            note: progressNote.note
        )
    }

    func mapToRealm(progressNote: ProgressNoteEntity) -> ProgressNote {
        let newNote = ProgressNote()
        if let startPage = progressNote.startPage{
            newNote.startPage = Int(startPage)
        }else {newNote.startPage = nil}
        if let endPage = progressNote.endPage{
            newNote.endPage = Int(endPage)
        }else {newNote.endPage = nil}
        newNote.date = progressNote.date
        newNote.note = progressNote.note
        return newNote
    }
}
