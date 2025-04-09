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
    func getAllBooks() -> AnyPublisher<[Record], Error>
    func getBook(with id: String) -> AnyPublisher<Record?, Error>
    func saveBook(_ book: Record) -> AnyPublisher<String, Error>
    func updateBook(_ book: Record) -> AnyPublisher<Void, Error>
    func deleteBook(with id: String) -> AnyPublisher<Void, Error>
    func getBooks(withStatus status: RecordStatus) -> AnyPublisher<[Record], Error>
    func getBooks(withCategory category: String) -> AnyPublisher<[Record], Error>
    func getBooks(withFeeling feeling: FeelingTagObject) -> AnyPublisher<[Record], Error>
    func resetBooks() -> AnyPublisher<Void, Error>
}
