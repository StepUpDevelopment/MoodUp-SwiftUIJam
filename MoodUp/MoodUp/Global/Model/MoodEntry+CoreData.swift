//
//  MoodEntry+CoreData.swift
//  MoodUp
//
//  Created by Nicolas Spinner on 19.02.21.
//

import Foundation
import CoreData

extension MoodEntry {
    
    func coreDataModel(context: NSManagedObjectContext) -> DbMoodEntry {
        let dbEntry = DbMoodEntry(context: context)
        dbEntry.text = text
        dbEntry.createdDate = createdDate
        dbEntry.type = Int64(moodType.rawValue)
        return dbEntry
    }
    
}

extension DbMoodEntry {
    
    func moodEntry() -> MoodEntry {
        MoodEntry(moodType: MoodType(rawValue: Int(type)) ?? .okay,
                  categories: [],
                  text: text,
                  createdDate: createdDate ?? Date())
    }
    
}
