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
protocol RecordDataSourceProtocol {
    func getAllNotes() -> AnyPublisher<[Record], Error>
    func getNote(with id: String) -> AnyPublisher<Record?, Error>
    func saveNote(_ note: Record) -> AnyPublisher<String, Error>
    func updateNote(_ note: Record) -> AnyPublisher<Void, Error>
    func deleteNote(with id: String) -> AnyPublisher<Void, Error>
    func getNotes(withStatus status: RecordStatus) -> AnyPublisher<[Record], Error>
    func getNotes(withCategory category: String) -> AnyPublisher<[Record], Error>
    func getNotes(withFeelingName name: String) -> AnyPublisher<[Record], Error>
    func resetNotes() -> AnyPublisher<Void, Error>
    func updateMetaData(id: String, metaData: MetadataEntity) ->  AnyPublisher<Void, Error>
    func updateDetail(id: String, detail: DetailEntity) -> AnyPublisher<Void, Error>
    func updateBeforeNote(id: String, note: NoteEntity?) -> AnyPublisher<Void, Error>
    func updateAfterNote(id: String, note: NoteEntity?) -> AnyPublisher<Void, Error>
    func addProgressNote(id: String, note: ProgressNoteEntity) -> AnyPublisher<Void, Error>
    func updateProgressNote(id: String, at index: Int, note: ProgressNoteEntity) -> AnyPublisher<Void, Error>
}
