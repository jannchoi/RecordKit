//
//  ProgressNoteEntity.swift
//  RecordKit
//
//  Created by 최정안 on 4/10/25.
//

import Foundation
struct ProgressNoteEntity {
    let id = UUID()
    let startPage: String?
    let endPage: String?
    let date: Date?
    let note: String
}
