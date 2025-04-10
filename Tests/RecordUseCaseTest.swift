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
    
    override func setUpWithError() throws {
        usecase = RecordUseCase(repository: RecordRepository(dataSource: RecordDataSource(mapper: RecordMapper()), mapper: RecordMapper()))
    }

    override func tearDownWithError() throws {
        usecase = nil
    }

//    func test_save_get_data() throws {
//        var cancellables = Set<AnyCancellable>()
//        var rowData = RecordEntity(id: "1234", metaData: MetadataEntity(title: "teTitle", subtitle: "teSubtitle", addedDate: Date(), thumbnailPath: "imhPath"), detail: DetailEntity(status: .before, shortNote: "myshort", categoryTags: ["drama"], feelingTags: [FeelingTag(name: "happy", colorHex: "red", emoji: "smile")]), beforeRecord: NoteEntity(date: Date(), note: "beforeNote"), inProgressRecord: [], afterRecord: nil)
//        var Notes:[RecordEntity] = []
//        
//        usecase.saveNote( rowData).sink { error in
//            print("save",error)
//        } receiveValue: { _ in
//            print("save")
//        }.store(in: &cancellables)
//
//        usecase.getAllNotes().sink(receiveCompletion: { error in
//            print("get",error)
//        }, receiveValue: { data in
//            Notes = data
//        })
//    .store(in: &cancellables)
//        XCTAssertEqual(Notes.count, 1)
//}
//
//    func test_save_delete_data() throws {
//        var cancellables = Set<AnyCancellable>()
//        var rowData = RecordEntity(id: "1234", metaData: MetadataEntity(title: "teTitle", subtitle: "teSubtitle", addedDate: Date(), thumbnailPath: "imhPath"), detail: DetailEntity(status: .before, shortNote: "myshort", categoryTags: ["drama"], feelingTags: [FeelingTag(name: "happy", colorHex: "red", emoji: "smile")]), beforeRecord: NoteEntity(date: Date(), note: "beforeNote"), inProgressRecord: [], afterRecord: nil)
//        var Notes:[RecordEntity] = []
//        
//        usecase.saveNote( rowData).sink { error in
//            print("save",error)
//        } receiveValue: { _ in
//            print("save")
//        }.store(in: &cancellables)
//        
//        usecase.deleteNote(with: rowData.id ).sink(receiveCompletion: { error in
//            print("delete",error)
//        }, receiveValue: { _ in
//            print("delete")
//        })
//        
//    .store(in: &cancellables)
//        usecase.getAllNotes().sink(receiveCompletion: { error in
//            print("get",error)
//        }, receiveValue: { data in
//            Notes = data
//        })
//    .store(in: &cancellables)
//        XCTAssertEqual(Notes.count, 0)
//}
    func test_save_update_data() throws {
        var cancellables = Set<AnyCancellable>()
        var rowData = RecordEntity(id: "1234", metaData: MetadataEntity(title: "teTitle", subtitle: "teSubtitle", addedDate: Date(), thumbnailPath: "imhPath"), detail: DetailEntity(status: .before, shortNote: "myshort", categoryTags: ["drama"], feelingTags: [FeelingTag(name: "happy", colorHex: "red", emoji: "smile")]), beforeRecord: NoteEntity(date: Date(), note: "beforeNote"), inProgressRecord: [], afterRecord: nil)
        var Notes:[RecordEntity] = []
        usecase.updateMetaData(id: "1234", metaData: MetadataEntity(title: "newtitle", subtitle: "newsubtitle", addedDate: Date(), thumbnailPath: "newimg") ).sink(receiveCompletion: { error in
            print("update metaData",error)
        }, receiveValue: { _ in
            print("update metaData")
        })
        
    .store(in: &cancellables)
        usecase.getAllNotes().sink(receiveCompletion: { error in
            print("get",error)
        }, receiveValue: { data in
            Notes = data
        })
    .store(in: &cancellables)
        
        XCTAssertNotEqual(rowData.metaData.subtitle, Notes[0].metaData.subtitle, "subtitle 같아?")
        XCTAssertNotEqual(rowData.metaData.title, Notes[0].metaData.title, "title 같아?")
}

    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
