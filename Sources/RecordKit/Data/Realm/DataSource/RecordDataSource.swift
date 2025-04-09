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

    init(realm: Realm) {
        self.realm = realm
    }

    func getAllBooks() -> AnyPublisher<[Record], Error> {
        Deferred {
            let records = Array(self.realm.objects(Record.self))
            return Just(records)
                .setFailureType(to: Error.self)
        }
        .eraseToAnyPublisher()
    }

    func getBook(with id: String) -> AnyPublisher<Record?, Error> {
        Deferred {
            let record = self.realm.object(ofType: Record.self, forPrimaryKey: id)
            return Just(record)
                .setFailureType(to: Error.self)
        }
        .eraseToAnyPublisher()
    }

    func saveBook(_ record: Record) -> AnyPublisher<String, Error> {
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

    func updateBook(_ record: Record) -> AnyPublisher<Void, Error> {
        Deferred {
            Future<Void, Error> { promise in
                do {
                    try self.realm.write {
                        self.realm.add(record, update: .modified)
                    }
                    promise(.success(()))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func deleteBook(with id: String) -> AnyPublisher<Void, Error> {
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

    func getBooks(withStatus status: RecordStatus) -> AnyPublisher<[Record], Error> {
        Deferred {
            let records = self.realm.objects(Record.self).filter("status == %@", status.rawValue)
            return Just(Array(records))
                .setFailureType(to: Error.self)
        }
        .eraseToAnyPublisher()
    }

    func getBooks(withCategory category: String) -> AnyPublisher<[Record], Error> {
        Deferred {
            let records = self.realm.objects(Record.self).filter("ANY categories == %@", category)
            return Just(Array(records))
                .setFailureType(to: Error.self)
        }
        .eraseToAnyPublisher()
    }

    func getBooks(withFeeling feeling: FeelingTagObject) -> AnyPublisher<[Record], Error> {
        Deferred {
            let records = self.realm.objects(Record.self).filter("ANY feelings == %@", feeling)
            return Just(Array(records))
                .setFailureType(to: Error.self)
        }
        .eraseToAnyPublisher()
    }

    func resetBooks() -> AnyPublisher<Void, Error> {
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
}
