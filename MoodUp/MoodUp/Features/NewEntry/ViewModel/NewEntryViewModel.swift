//
//  NewEntryViewModel.swift
//  MoodUp
//
//  Created by Manuel Kunz on 20.02.21.
//

import Foundation
import SwiftUI

class NewEntryViewModel : ObservableObject {
	
	@Published var moodCategories: [MoodCategory] = []
	var moodType: MoodType
    
    var storageProvider: StorageProvider
    
    var selectedMoodCategories: [MoodCategory] = []
    var moodText: String?
	
	init(moodType: MoodType, storageProvider: StorageProvider) {
		self.moodType = moodType
		self.moodCategories = storageProvider.getAllCategories()
        self.storageProvider = storageProvider
	}
	
    func save() {
        let moodEntry = MoodEntry(moodType: moodType, categories: selectedMoodCategories, text: moodText)
        storageProvider.saveEntry(moodEntry: moodEntry)
    }
}
