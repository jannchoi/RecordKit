//
//  MetadataEntity.swift
//  RecordKit
//
//  Created by 최정안 on 4/10/25.
//

import Foundation
public struct MetadataEntity {
    public let title: String
    public let subtitle: String
    public let addedDate: Date
    public let thumbnailPath: String?

    public init(
        title: String,
        subtitle: String,
        addedDate: Date,
        thumbnailPath: String?
    ) {
        self.title = title
        self.subtitle = subtitle
        self.addedDate = addedDate
        self.thumbnailPath = thumbnailPath
    }
}
