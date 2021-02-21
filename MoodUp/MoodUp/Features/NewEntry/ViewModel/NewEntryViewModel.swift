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
    @Published var moodText: String = NSLocalizedString("new_entry_category_input_placeholder", comment: "")
    var moodType: MoodType
    
    var storageProvider: StorageProvider
    
    var selectedMoodCategories: [MoodCategory] = []
	
	init(moodType: MoodType, storageProvider: StorageProvider) {
		self.moodType = moodType
		self.moodCategories = storageProvider.getAllCategories()
        self.storageProvider = storageProvider
	}
	
    func save() {
        let moodNote: String?
        if moodText == NSLocalizedString("new_entry_category_input_placeholder", comment: "") {
            moodNote = nil
        } else {
            moodNote = moodText
        }
        let moodEntry = MoodEntry(moodType: moodType, categories: selectedMoodCategories, text: moodNote)
        storageProvider.saveEntry(moodEntry: moodEntry)
    }
}
