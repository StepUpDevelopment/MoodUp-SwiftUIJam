//
//  NewEntryCategoryViewModel.swift
//  MoodUp
//
//  Created by Manuel Kunz on 20.02.21.
//

import Foundation

class NewEntryCategoryViewModel : ObservableObject {
	
	@Published var moodCategories: [MoodCategory]
	
	private var moodType: MoodType
	
	init(moodType: MoodType, storageProvider: StorageProvider) {
		self.moodType = moodType
		self.moodCategories = storageProvider.getAllCategories()
	}
	
}
