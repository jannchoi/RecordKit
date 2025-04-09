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
class RecordDataSource: RecordDataSourceProtocol {

    private let realm: Realm
    private let mapper: RecordMapperProtocol

    init(realm: Realm = try! Realm(), mapper: RecordMapperProtocol) {
        self.realm = realm
        self.mapper = mapper
    }

    func getAllNotes() -> AnyPublisher<[Record], Error> {
        Deferred {
            let records = Array(self.realm.objects(Record.self))
            return Just(records)
                .setFailureType(to: Error.self)
        }
        .eraseToAnyPublisher()
    }

    func getNote(with id: String) -> AnyPublisher<Record?, Error> {
        Deferred {
            let record = self.realm.object(ofType: Record.self, forPrimaryKey: id)
            return Just(record)
                .setFailureType(to: Error.self)
        }
        .eraseToAnyPublisher()
    }

    func saveNote(_ record: Record) -> AnyPublisher<String, Error> {
        Deferred {
            Future<String, Error> { promise in
                do {
                    try self.realm.write {
                        self.realm.add(record)
                    }
                    promise(.success(record.id))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func updateNote(_ note: Record) -> AnyPublisher<Void, Error> {
        Deferred {
            Future<Void, Error> { promise in
                do {
                    try self.realm.write {
                        self.realm.add(note, update: .modified)
                    }
                    promise(.success(()))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func deleteNote(with id: String) -> AnyPublisher<Void, Error> {
        Deferred {
            Future<Void, Error> { promise in
                do {
                    if let record = self.realm.object(ofType: Record.self, forPrimaryKey: id) {
                        try self.realm.write {
                            self.realm.delete(record)
                        }
                    }
                    promise(.success(()))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func getNotes(withStatus status: RecordStatus) -> AnyPublisher<[Record], Error> {
        Deferred {
            let records = self.realm.objects(Record.self).filter("status == %@", status.rawValue)
            return Just(Array(records))
                .setFailureType(to: Error.self)
        }
        .eraseToAnyPublisher()
    }

    func getNotes(withCategory category: String) -> AnyPublisher<[Record], Error> {
        Deferred {
            let records = self.realm.objects(Record.self).filter("ANY categories == %@", category)
            return Just(Array(records))
                .setFailureType(to: Error.self)
        }
        .eraseToAnyPublisher()
    }

    func getNotes(withFeelingName name: String) -> AnyPublisher<[Record], Error> {
        Deferred {
            let records = self.realm.objects(Record.self).filter("ANY feelings.name == %@", name)
            return Just(Array(records))
                .setFailureType(to: Error.self)
        }
        .eraseToAnyPublisher()
    }

    func resetNotes() -> AnyPublisher<Void, Error> {
        Deferred {
            Future<Void, Error> { promise in
                do {
                    try self.realm.write {
                        self.realm.deleteAll()
                    }
                    promise(.success(()))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    func updateMetaData(id: String, metaData: MetadataEntity) -> AnyPublisher<Void, Error> {
           Deferred {
               Future { promise in
                   do {
                       guard let record = self.realm.object(ofType: Record.self, forPrimaryKey: id) else {
                           throw NSError(domain: "Record not found", code: 0)
                       }
                       try self.realm.write {
                           record.title = metaData.title
                           record.subtitle = metaData.subtitle
                           record.addedDate = metaData.addedDate
                           record.thumbnailPath = metaData.thumbnailPath
                       }
                       promise(.success(()))
                   } catch {
                       promise(.failure(error))
                   }
               }
           }
           .eraseToAnyPublisher()
       }

       // MARK: - Detail 업데이트
       func updateDetail(id: String, detail: DetailEntity) -> AnyPublisher<Void, Error> {
           Deferred {
               Future { promise in
                   do {
                       guard let record = self.realm.object(ofType: Record.self, forPrimaryKey: id) else {
                           throw NSError(domain: "Record not found", code: 0)
                       }

                       let feelingObjects = detail.feelingTags.map { tag in
                           let obj = FeelingTagObject()
                           obj.name = tag.name
                           obj.colorHex = tag.colorHex
                           obj.emoji = tag.emoji
                           return obj
                       }

                       try self.realm.write {
                           record.recordStatus = RecordStatus(rawValue: detail.status.rawValue) ?? .unread
                           record.shortNote = detail.shortNote
                           record.categoryTags.removeAll()
                           record.categoryTags.append(objectsIn: detail.categoryTags)
                           record.feelingTags.removeAll()
                           record.feelingTags.append(objectsIn: feelingObjects)
                       }
                       promise(.success(()))
                   } catch {
                       promise(.failure(error))
                   }
               }
           }
           .eraseToAnyPublisher()
       }

       // MARK: - Before Note 업데이트
       func updateBeforeNote(id: String, note: NoteEntity?) -> AnyPublisher<Void, Error> {
           Deferred {
               Future { promise in
                   do {
                       guard let record = self.realm.object(ofType: Record.self, forPrimaryKey: id) else {
                           throw NSError(domain: "Record not found", code: 0)
                       }

                       try self.realm.write {
                           record.beforeNote = note.map { self.mapper.mapToRealm(note: $0) }
                       }
                       promise(.success(()))
                   } catch {
                       promise(.failure(error))
                   }
               }
           }
           .eraseToAnyPublisher()
       }

       // MARK: - After Note 업데이트
       func updateAfterNote(id: String, note: NoteEntity?) -> AnyPublisher<Void, Error> {
           Deferred {
               Future { promise in
                   do {
                       guard let record = self.realm.object(ofType: Record.self, forPrimaryKey: id) else {
                           throw NSError(domain: "Record not found", code: 0)
                       }

                       try self.realm.write {
                           record.afterNote = note.map { self.mapper.mapToRealm(note: $0) }
                       }
                       promise(.success(()))
                   } catch {
                       promise(.failure(error))
                   }
               }
           }
           .eraseToAnyPublisher()
       }

       // MARK: - Progress Note 추가
       func addProgressNote(id: String, note: ProgressNoteEntity) -> AnyPublisher<Void, Error> {
           Deferred {
               Future { promise in
                   do {
                       guard let record = self.realm.object(ofType: Record.self, forPrimaryKey: id) else {
                           throw NSError(domain: "Record not found", code: 0)
                       }

                       let realmNote = self.mapper.mapToRealm(progressNote: note)

                       try self.realm.write {
                           record.inProgressNote.append(realmNote)
                       }

                       promise(.success(()))
                   } catch {
                       promise(.failure(error))
                   }
               }
           }
           .eraseToAnyPublisher()
       }

       // MARK: - Progress Note 수정
       func updateProgressNote(id: String, at index: Int, note: ProgressNoteEntity) -> AnyPublisher<Void, Error> {
           Deferred {
               Future { promise in
                   do {
                       guard let record = self.realm.object(ofType: Record.self, forPrimaryKey: id),
                             record.inProgressNote.indices.contains(index) else {
                           throw NSError(domain: "ProgressNote not found", code: 0)
                       }

                       let updatedNote = self.mapper.mapToRealm(progressNote: note)

                       try self.realm.write {
                           record.inProgressNote[index] = updatedNote
                       }

                       promise(.success(()))
                   } catch {
                       promise(.failure(error))
                   }
               }
           }
           .eraseToAnyPublisher()
       }

}
