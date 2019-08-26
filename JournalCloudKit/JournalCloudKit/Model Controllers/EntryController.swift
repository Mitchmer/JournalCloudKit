//
//  EntryController.swift
//  JournalCloudKit
//
//  Created by Mitch Merrell on 8/26/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

import Foundation
import CloudKit

class EntryController {
    
    static let shared = EntryController()
    var entries: [Entry] = []
    
    func saveEntry(entry: Entry, completion: @escaping (Bool) -> Void) {
        let newEntry = CKRecord(entry: entry)
        CKContainer.default().publicCloudDatabase.save(newEntry) { (_, error) in
            if let error = error {
                print("Error: \(error), \(error.localizedDescription)")
                completion(false)
                return
            }
            self.entries.append(entry)
            completion(true)
        }
    }
    
    func addEntryWith(title: String, body: String, completion: @escaping (Bool) -> Void) {
        let entry = Entry(title: title, body: body)
        saveEntry(entry: entry) { (success) in
            success ? completion(true) : completion(false)
        }
    }
    
    func fetchEntries(completion: @escaping (Bool) -> ()) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: Constants.typeKey, predicate: predicate)
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith:nil) { (records, error) in
            if let error = error {
                print("Error: \(error), \(error.localizedDescription)")
                completion(false)
                return
            }
            guard let records = records else { completion(false); return }
            
            let entryArray = records.compactMap({ Entry(ckRecord: $0) })
            self.entries = entryArray
            completion(true)
        }
    }
}
