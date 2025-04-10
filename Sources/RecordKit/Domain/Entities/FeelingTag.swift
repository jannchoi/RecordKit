//
//  FiFeelingTagle.swift
//  RecordKit
//
//  Created by 최정안 on 4/10/25.
//

import Foundation
public struct FeelingTag {
    public let name: String
    public let colorHex: String
    public let emoji: String

    public init(name: String, colorHex: String, emoji: String) {
        self.name = name
        self.colorHex = colorHex
        self.emoji = emoji
    }
}
