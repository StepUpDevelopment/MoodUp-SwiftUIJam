//
//  TimelineViewModel.swift
//  MoodUp
//
//  Created by Nicolas Spinner on 20.02.21.
//

import Foundation
import SwiftUI
import Combine

class TimelineViewModel: ObservableObject {
    
    let storageProvider: StorageProvider
//    @Published var moodEntries: [MoodEntry] = []
	private var cancellable = Set<AnyCancellable>()
    
	@Published var sections: [ListSection<MoodEntry>] = []
	
    init(storageProvider: StorageProvider) {
        self.storageProvider = storageProvider
		sections = self.convertToSections(from: storageProvider.getAllEntries())
		subscriveToImageEntries()
    }
	
	private func subscriveToImageEntries() {
		storageProvider
			.observe()
			.sink(receiveValue: {
				self.appendItemsToSections(items: $0)
			})
			.store(in: &cancellable)
	}
	
	private func appendItemsToSections(items: [MoodEntry]) {
		items.forEach { currentEntry in
			let dayName = currentEntry.createdDate.fullName()
			if sections.isEmpty || sections.first?.title != dayName {
				sections.insert(ListSection(title: dayName, items: [currentEntry]), at: 0)
			} else {
				sections[0].items.insert(currentEntry, at: 0)
			}
			
		}		
	}

	private func convertToSections(from entries: [MoodEntry]) -> [ListSection<MoodEntry>] {
		
		let workoutSections = entries.reduce(into: [ListSection<MoodEntry>]()) { sections, currentEntry in
			
			let dayName = currentEntry.createdDate.fullName()
			if sections.isEmpty || sections[sections.zeroIndexedCount].title != dayName {
				sections.append(ListSection(title: dayName, items: [currentEntry]))
			} else {
				sections[sections.zeroIndexedCount].items.append(currentEntry)
			}
		}
		return workoutSections
	}
    
}
