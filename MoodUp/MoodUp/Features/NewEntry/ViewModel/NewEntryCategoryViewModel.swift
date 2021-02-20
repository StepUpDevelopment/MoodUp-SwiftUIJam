//
//  NewEntryCategoryViewModel.swift
//  MoodUp
//
//  Created by Manuel Kunz on 20.02.21.
//

import Foundation
import SwiftUI

class NewEntryCategoryViewModel : ObservableObject {
	
	@Published var moodCategories: [MoodCategory] = []
	private var moodType: MoodType
    
    var storageProvider: StorageProvider
    
    var selectedMoodCategories: [MoodCategory] = []
	
	init(moodType: MoodType, storageProvider: StorageProvider) {
		self.moodType = moodType
		self.moodCategories = storageProvider.getAllCategories()
        self.storageProvider = storageProvider
	}
	
    func save() {
        let moodEntry = MoodEntry(moodType: moodType, categories: selectedMoodCategories)
        storageProvider.saveEntry(moodEntry: moodEntry)
    }
}
