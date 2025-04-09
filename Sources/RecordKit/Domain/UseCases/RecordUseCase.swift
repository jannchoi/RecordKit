//
//  File.swift
//  RecordKit
//
//  Created by 최정안 on 4/10/25.
//

import Foundation
import Combine
@available(iOS 13.0, *)
final class RecordUseCase: RecordUseCaseProtocol {
    private let repository: RecordRepositoryProtocol

    init(repository: RecordRepositoryProtocol) {
        self.repository = repository
    }

    func getAllNotes() -> AnyPublisher<[RecordEntity], Error> {
        return repository.getAllNotes()
    }

    func getNote(with id: String) -> AnyPublisher<RecordEntity?, Error> {
        return repository.getNote(with: id)
    }

    func saveNote(_ note: RecordEntity) -> AnyPublisher<String, Error> {
        return repository.saveNote(note)
    }

    func deleteNote(with id: String) -> AnyPublisher<Void, Error> {
        return repository.deleteNote(with: id)
    }

    func updateNote(_ note: RecordEntity) -> AnyPublisher<Void, Error> {
        return repository.updateNote(note)
    }

    func getNotes(withStatus status: StatusEntity) -> AnyPublisher<[RecordEntity], Error> {
        return repository.getNotes(withStatus: status)
    }

    func getNotes(withCategory category: String) -> AnyPublisher<[RecordEntity], Error> {
        return repository.getNotes(withCategory: category)
    }

    func getNotes(withFeeling feeling: FeelingTag) -> AnyPublisher<[RecordEntity], Error> {
        return repository.getNotes(withFeeling: feeling)
    }

    func resetNotes() -> AnyPublisher<Void, Error> {
        return repository.resetNotes()
    }

    func updateMetaData(id: String, metaData: MetadataEntity) -> AnyPublisher<Void, Error> {
        return repository.updateMetaData(id: id, metaData: metaData)
    }

    func updateDetail(id: String, detail: DetailEntity) -> AnyPublisher<Void, Error> {
        return repository.updateDetail(id: id, detail: detail)
    }

    func updateBeforeNote(id: String, note: NoteEntity?) -> AnyPublisher<Void, Error> {
        return repository.updateBeforeNote(id: id, note: note)
    }

    func updateAfterNote(id: String, note: NoteEntity?) -> AnyPublisher<Void, Error> {
        return repository.updateAfterNote(id: id, note: note)
    }

    func addProgressNote(id: String, note: ProgressNoteEntity) -> AnyPublisher<Void, Error> {
        return repository.addProgressNote(id: id, note: note)
    }

    func updateProgressNote(id: String, at index: Int, note: ProgressNoteEntity) -> AnyPublisher<Void, Error> {
        return repository.updateProgressNote(id: id, at: index, note: note)
    }
}
