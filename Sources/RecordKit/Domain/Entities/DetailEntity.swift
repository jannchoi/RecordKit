//
//  DetailEntity.swift
//  RecordKit
//
//  Created by 최정안 on 4/10/25.
//

import Foundation
public struct DetailEntity {
    public let status: StatusEntity
    public let shortNote: String
    public let categoryTags: [String]
    public let feelingTags: [FeelingTag]

    public init(
        status: StatusEntity,
        shortNote: String,
        categoryTags: [String],
        feelingTags: [FeelingTag]
    ) {
        self.status = status
        self.shortNote = shortNote
        self.categoryTags = categoryTags
        self.feelingTags = feelingTags
    }
}
