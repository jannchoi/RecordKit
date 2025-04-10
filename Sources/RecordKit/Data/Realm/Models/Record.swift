//
//  File.swift
//  RecordKit
//
//  Created by 최정안 on 4/10/25.
//

import Foundation
import RealmSwift

class Record: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var thumbnailPath: String?
    @Persisted var addedDate: Date
    @Persisted var title: String
    @Persisted var subtitle: String
    @Persisted var recordStatus: RecordStatus
    @Persisted var shortNote: String
    @Persisted var categoryTags: List<String>
    @Persisted var feelingTags: List<FeelingTagObject>
    @Persisted var beforeNote: Note?
    @Persisted var inProgressNote: List<ProgressNote>
    @Persisted var afterNote: Note?

    convenience init(id: String,
        imagePath: String?,
        title: String,
        author: String,
        recordStatus: RecordStatus,
        shortNote: String,
        categories: [String],
        feelings: [FeelingTagObject],
        beforeNote: Note?,
        inProgressNote: [ProgressNote],
        afterNote: Note?
    ) {
        self.init()
        self.id = id
        self.thumbnailPath = imagePath
        self.addedDate = Date()
        self.title = title
        self.subtitle = author
        self.recordStatus = recordStatus
        self.shortNote = shortNote
        self.categoryTags.append(objectsIn: categories)
        self.feelingTags.append(objectsIn: feelingTags)
        self.beforeNote = beforeNote
        self.inProgressNote.append(objectsIn: inProgressNote)
        self.afterNote = afterNote
    }

}
