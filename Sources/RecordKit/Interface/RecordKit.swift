// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
public enum RecordKit {
    public static func makeUseCase() -> RecordUseCaseProtocol {
        let mapper = RecordMapper()
        let dataSource = RecordDataSource(mapper: mapper)
        let repository = RecordRepository(dataSource: dataSource, mapper: mapper)
        let useCase = RecordUseCase(repository: repository)
        return useCase
    }
    public static func makeUseCase(repository: RecordRepositoryProtocol) -> RecordUseCaseProtocol {
        return RecordUseCase(repository: repository)
    }

}
