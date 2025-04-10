//
//  File.swift
//  RecordKit
//
//  Created by 최정안 on 4/10/25.
//

import Foundation
import Combine

@available(iOS 13.0, *)
public protocol RecordUseCaseProtocol {
    func getAllNotes() -> AnyPublisher<[RecordEntity], Error>
    func getNote(with id: String) -> AnyPublisher<RecordEntity?, Error>
    func saveNote(_ note: RecordEntity) -> AnyPublisher<String, Error>
    func deleteNote(with id: String) -> AnyPublisher<Void, Error>
    func updateNote(_ note: RecordEntity) -> AnyPublisher<Void, Error>
    func getNotes(withStatus status: StatusEntity) -> AnyPublisher<[RecordEntity], Error>
    func getNotes(withCategory category: String) -> AnyPublisher<[RecordEntity], Error>
    func getNotes(withFeeling feeling: FeelingTag) -> AnyPublisher<[RecordEntity], Error>
    func resetNotes() -> AnyPublisher<Void, Error>
    func updateMetaData(id: String, metaData: MetadataEntity) -> AnyPublisher<Void, Error>
    func updateDetail(id: String, detail: DetailEntity) -> AnyPublisher<Void, Error>
    func updateBeforeNote(id: String, note: NoteEntity?) -> AnyPublisher<Void, Error>
    func updateAfterNote(id: String, note: NoteEntity?) -> AnyPublisher<Void, Error>
    func addProgressNote(id: String, note: ProgressNoteEntity) -> AnyPublisher<Void, Error>
    func updateProgressNote(id: String, at index: Int, note: ProgressNoteEntity) -> AnyPublisher<Void, Error>
}
