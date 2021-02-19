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
		return dbMoodCategory
	}
		
}

extension DbMoodCategory {
	
	func moodCategory() -> MoodCategory {
		let moodCategory = MoodCategory(title: title ?? "", iconName: iconName ?? "")
		return moodCategory
	}
	
}
