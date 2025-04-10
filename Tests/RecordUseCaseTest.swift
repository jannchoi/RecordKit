//
//  RecordUseCaseTest.swift
//  RecordKit
//
//  Created by 최정안 on 4/10/25.
//

import XCTest
import Combine
@testable import RecordKit

final class RecordUseCaseTest: XCTestCase {

    var usecase: RecordUseCaseProtocol!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        usecase = RecordUseCase(repository: RecordRepository(dataSource: RecordDataSource(mapper: RecordMapper()), mapper: RecordMapper()))
        cancellables = []
    }

    override func tearDownWithError() throws {
        usecase = nil
        cancellables = nil
    }

    func test_save_get_data() throws {
        let expectation = XCTestExpectation(description: "Save and fetch note")
        let id = UUID().uuidString

        let rowData = RecordEntity(
            id: id,
            metaData: MetadataEntity(title: "teTitle", subtitle: "teSubtitle", addedDate: Date(), thumbnailPath: "imhPath"),
            detail: DetailEntity(status: .before, shortNote: "myshort", categoryTags: ["drama"], feelingTags: [FeelingTag(name: "happy", colorHex: "red", emoji: "smile")]),
            beforeRecord: NoteEntity(date: Date(), note: "beforeNote"),
            inProgressRecord: [],
            afterRecord: nil
        )

        usecase.saveNote(rowData)
            .flatMap { _ in self.usecase.getAllNotes() }
            .sink(receiveCompletion: { _ in }, receiveValue: { notes in
                XCTAssertTrue(notes.contains(where: { $0.id == id }))
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 3.0)
    }

    func test_save_delete_data() throws {
        let expectation = XCTestExpectation(description: "Save and delete note")
        let id = UUID().uuidString

        let rowData = RecordEntity(
            id: id,
            metaData: MetadataEntity(title: "teTitle", subtitle: "teSubtitle", addedDate: Date(), thumbnailPath: "imhPath"),
            detail: DetailEntity(status: .before, shortNote: "myshort", categoryTags: ["drama"], feelingTags: [FeelingTag(name: "happy", colorHex: "red", emoji: "smile")]),
            beforeRecord: NoteEntity(date: Date(), note: "beforeNote"),
            inProgressRecord: [],
            afterRecord: nil
        )

        usecase.saveNote(rowData)
            .flatMap { _ in self.usecase.deleteNote(with: id) }
            .flatMap { _ in self.usecase.getAllNotes() }
            .sink(receiveCompletion: { _ in }, receiveValue: { notes in
                XCTAssertFalse(notes.contains(where: { $0.id == id }))
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 3.0)
    }

    func test_save_update_data() throws {
        let expectation = XCTestExpectation(description: "Save and update metadata")
        let id = UUID().uuidString

        let originalMeta = MetadataEntity(title: "teTitle", subtitle: "teSubtitle", addedDate: Date(), thumbnailPath: "imhPath")

        let rowData = RecordEntity(
            id: id,
            metaData: originalMeta,
            detail: DetailEntity(status: .before, shortNote: "myshort", categoryTags: ["drama"], feelingTags: [FeelingTag(name: "happy", colorHex: "red", emoji: "smile")]),
            beforeRecord: NoteEntity(date: Date(), note: "beforeNote"),
            inProgressRecord: [],
            afterRecord: nil
        )

        let updatedMeta = MetadataEntity(title: "newTitle", subtitle: "newSubtitle", addedDate: Date(), thumbnailPath: "newImg")

        usecase.saveNote(rowData)
            .flatMap { _ in self.usecase.updateMetaData(id: id, metaData: updatedMeta) }
            .flatMap { _ in self.usecase.getAllNotes() }
            .sink(receiveCompletion: { _ in }, receiveValue: { notes in
                if let updated = notes.first(where: { $0.id == id }) {
                    XCTAssertEqual(updated.metaData.title, "newTitle")
                    XCTAssertEqual(updated.metaData.subtitle, "newSubtitle")
                } else {
                    XCTFail("Updated note not found")
                }
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 3.0)
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
