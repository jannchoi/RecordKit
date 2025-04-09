//
//  File.swift
//  RecordKit
//
//  Created by 최정안 on 4/10/25.
//

import Foundation
import RealmSwift

enum RecordStatus: String, PersistableEnum {
    case unread
    case inProgress
    case completed
}
