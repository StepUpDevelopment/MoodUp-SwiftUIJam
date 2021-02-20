//
//  MoodEntry.swift
//  MoodUp
//
//  Created by Nicolas Spinner on 19.02.21.
//

import Foundation

struct MoodEntry: Hashable, Identifiable {
    
    var moodType: MoodType
    var categories: [MoodCategory] = []
    var text: String?
    var createdDate: Date = Date()
	var id: Date {
		createdDate
	}
}
