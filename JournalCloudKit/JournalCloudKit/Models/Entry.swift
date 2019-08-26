//
//  Entry.swift
//  JournalCloudKit
//
//  Created by Mitch Merrell on 8/26/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

import Foundation
import CloudKit

struct Constants {
    static let typeKey = "Entry"
    static let titleKey = "title"
    static let bodyKey = "body"
    static let timestampKey = "timestamp"
}

class Entry {
    let title: String
    let body: String
    let timestamp: Date
    let ckRecordID: CKRecord.ID
    
    init(title: String, body:String, timestamp: Date = Date(), ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.title = title
        self.body = body
        self.timestamp = timestamp
        self.ckRecordID = ckRecordID
    }
}

extension Entry {
    convenience init?(ckRecord: CKRecord) {
        guard let title = ckRecord[Constants.titleKey] as? String,
            let body = ckRecord[Constants.bodyKey] as? String,
            let timestamp = ckRecord[Constants.timestampKey] as? Date else { return nil }
        self.init(title: title, body: body, timestamp: timestamp, ckRecordID: ckRecord.recordID)
    }
}

extension CKRecord {
    convenience init(entry: Entry) {
        self.init(recordType: Constants.typeKey, recordID: entry.ckRecordID)
        self.setValue(entry.title, forKey: Constants.titleKey)
        self.setValue(entry.body, forKey: Constants.bodyKey)
        self.setValue(entry.timestamp, forKey: Constants.timestampKey)
    }
}
