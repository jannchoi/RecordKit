//
//  NoteEntity.swift
//  RecordKit
//
//  Created by 최정안 on 4/10/25.
//

import Foundation
public struct NoteEntity {
    let id = UUID()
    let date: Date?
    let note: String
}
