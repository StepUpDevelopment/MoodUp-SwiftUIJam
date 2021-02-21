//
//  MoodCategory+CoreData.swift
//  MoodUp
//
//  Created by Manuel Kunz on 19.02.21.
//

import Foundation

import CoreData

extension MoodCategory {
	
	func coreDataModel(context: NSManagedObjectContext) -> DbMoodCategory {
		let dbMoodCategory = DbMoodCategory(context: context)
		dbMoodCategory.title = title
		dbMoodCategory.iconName = iconName
		dbMoodCategory.identifier = Int64(identifier)
		return dbMoodCategory
	}
		
}

extension DbMoodCategory {
	
	func moodCategory() -> MoodCategory {

		guard let entries = self.entries as? Set<DbMoodEntry> else {
			preconditionFailure("Failed to load categories")
		}
		let moodCategory = MoodCategory(
			identifier: Int(identifier),
			title: title ?? "",
			iconName: iconName ?? "",
			moodEntries: Array(entries).map { $0.moodEntry(withoutCategory: true) }
		)
		return moodCategory
	}
}
