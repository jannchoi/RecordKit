//
//  File.swift
//  RecordKit
//
//  Created by 최정안 on 4/10/25.
//

import Foundation
import Combine
import RealmSwift
@available(iOS 13.0, *)
class RecordRepository: RecordRepositoryProtocol {
    
    private let dataSource: RecordDataSourceProtocol
    private let mapper: RecordMapperProtocol
    
    init(dataSource: RecordDataSourceProtocol, mapper: RecordMapperProtocol) {
        self.dataSource = dataSource
        self.mapper = mapper
    }
    
    func getAllNotes() -> AnyPublisher<[RecordEntity], Error> {
        return dataSource.getAllNotes()
            .map { note in
                note.map { self.mapper.mapToDomain(realmModel: $0) }
            }
            .eraseToAnyPublisher()
    }
    
    func getNote(with id: String) -> AnyPublisher<RecordEntity?, Error> {
        return dataSource.getNote(with: id)
            .map { note in
                note.map { self.mapper.mapToDomain(realmModel: $0) }
            }
            .eraseToAnyPublisher()
    }
    
    func saveNote(_ note: RecordEntity) -> AnyPublisher<String, Error> {
        
        let realmModel = mapper.mapToRealm(domainModel: note)
        return dataSource.saveNote(realmModel)
            .eraseToAnyPublisher()
    }
    
    func deleteNote(with id: String) -> AnyPublisher<Void, Error> {
        return dataSource.deleteNote(with: id)
    }
    func updateNote(_ note: RecordEntity) -> AnyPublisher<Void, Error> {
        let recordObject = mapper.mapToRealm(domainModel: note)
        
        return dataSource.updateNote(recordObject)
    }
    
    func getNotes(withStatus status: StatusEntity) -> AnyPublisher<[RecordEntity], Error> {
        let realmStatus = RecordStatus(rawValue: status.rawValue) ?? .unread
        return dataSource.getNotes(withStatus: realmStatus)
            .map { note in
                note.map { self.mapper.mapToDomain(realmModel: $0) }
            }
            .eraseToAnyPublisher()
    }
    
    func getNotes(withCategory category: String) -> AnyPublisher<[RecordEntity], Error> {
        return dataSource.getNotes(withCategory: category)
            .map { note in
                note.map { self.mapper.mapToDomain(realmModel: $0) }
            }
            .eraseToAnyPublisher()
    }
    
    func getNotes(withFeeling feeling: FeelingTag) -> AnyPublisher<[RecordEntity], Error> {
        return dataSource.getNotes(withFeelingName: feeling.name)
            .map { records in
                records.map { self.mapper.mapToDomain(realmModel: $0) }
            }
            .eraseToAnyPublisher()
    }
    
    func resetNotes() -> AnyPublisher<Void, Error> {
        return dataSource.resetNotes()
    }

    func updateMetaData(id: String, metaData: MetadataEntity) -> AnyPublisher<Void, Error> {
        return dataSource.updateMetaData(id: id, metaData: metaData)
    }

    func updateDetail(id: String, detail: DetailEntity) -> AnyPublisher<Void, Error> {
        return dataSource.updateDetail(id: id, detail: detail)
    }

    func updateBeforeNote(id: String, note: NoteEntity?) -> AnyPublisher<Void, Error> {
        return dataSource.updateBeforeNote(id: id, note: note)
    }

    func updateAfterNote(id: String, note: NoteEntity?) -> AnyPublisher<Void, Error> {
        return dataSource.updateAfterNote(id: id, note: note)
    }

    func addProgressNote(id: String, note: ProgressNoteEntity) -> AnyPublisher<Void, Error> {
        return dataSource.addProgressNote(id: id, note: note)
    }

    func updateProgressNote(id: String, at index: Int, note: ProgressNoteEntity) -> AnyPublisher<Void, Error> {
        return dataSource.updateProgressNote(id: id, at: index, note: note)
    }

    func removeProgressNote(id: String, at index: Int) -> AnyPublisher<Void, Error> {
        return dataSource.removeProgressNote(id: id, at: index)
    }
}

