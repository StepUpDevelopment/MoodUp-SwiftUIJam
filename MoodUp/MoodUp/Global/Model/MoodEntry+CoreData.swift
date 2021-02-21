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
    
	func moodEntry(withoutCategory: Bool = false) -> MoodEntry {
		if withoutCategory {
			return MoodEntry(moodType: MoodType(rawValue: Int(type)) ?? .okay,
							 categories: [],
					  text: text,
					  createdDate: createdDate ?? Date())
			
		}
        guard let categories = self.categories as? Set<DbMoodCategory> else {
            preconditionFailure("Failed to load categories")
        }
        return MoodEntry(moodType: MoodType(rawValue: Int(type)) ?? .okay,
                         categories: Array(categories).map { $0.moodCategory() },
                  text: text,
                  createdDate: createdDate ?? Date())
    }
    
}
