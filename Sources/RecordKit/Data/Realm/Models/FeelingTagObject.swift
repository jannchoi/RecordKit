//
//  File.swift
//  RecordKit
//
//  Created by 최정안 on 4/10/25.
//

import Foundation
import RealmSwift
class FeelingTagObject: Object {
    @Persisted var name: String
    @Persisted var colorHex: String
    @Persisted var emoji: String
}
