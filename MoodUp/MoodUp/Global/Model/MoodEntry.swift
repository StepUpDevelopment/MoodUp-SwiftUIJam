//
//  MoodEntry.swift
//  MoodUp
//
//  Created by Nicolas Spinner on 19.02.21.
//

import Foundation

struct MoodEntry {
    
    var moodType: MoodType
    var categories: [MoodCategory] = []
    var text: String?
    var createdDate: Date = Date()
}
