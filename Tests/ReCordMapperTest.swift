//
//  ReCordMapperTest.swift
//  RecordKit
//
//  Created by 최정안 on 4/10/25.
//

import XCTest
@testable import RecordKit

final class ReCordMapperTest: XCTestCase {
    
    var mapper: RecordMapperProtocol!
    override func setUpWithError() throws {
        mapper = RecordMapper()
    }
    
    override func tearDownWithError() throws {
        mapper = nil
    }
    
    func test_toRealm_withValidEntity_returnsRecordObject() throws {
        // given
        let entity = RecordEntity(id: "1234", metaData: MetadataEntity(title: "teTitle", subtitle: "teSubtitle", addedDate: Date(), thumbnailPath: "imhPath"), detail: DetailEntity(status: .before, shortNote: "myshort", categoryTags: ["drama"], feelingTags: [FeelingTag(name: "happy", colorHex: "red", emoji: "smile")]), beforeRecord: NoteEntity(date: Date(), note: "beforeNote"), inProgressRecord: [], afterRecord: nil)
        
        // when
        let object = mapper.mapToRealm(domainModel: entity)
        print(object.feelingTags)
        // then
        XCTAssertEqual(object.id, entity.id)
        XCTAssertEqual(object.title, entity.metaData.title)
        XCTAssertEqual(object.recordStatus.rawValue, entity.detail.status.rawValue)
        XCTAssertEqual(object.feelingTags.count, entity.detail.feelingTags.count)

    }

    func test_toEntity_withValidObject_returnsEntity() throws {
        // given
        let object = Record()
        object.id = "456"
        object.title = "테스트 제목"
        object.recordStatus = .completed
        object.categoryTags.append("Drama")
        // when
        let entity = mapper.mapToDomain(realmModel: object)
        
        // then
        XCTAssertEqual(entity.id, object.id)
        XCTAssertEqual(entity.metaData.title, object.title)
        XCTAssertEqual(entity.detail.status.rawValue, object.recordStatus.rawValue)
        XCTAssertEqual(entity.detail.categoryTags.count, object.categoryTags.count)
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
