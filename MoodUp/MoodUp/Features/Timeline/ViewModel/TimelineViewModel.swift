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
    @Published var moodEntries: [MoodEntry] = []
	private var cancellable = Set<AnyCancellable>()
    
    init(storageProvider: StorageProvider) {
        self.storageProvider = storageProvider
        moodEntries = storageProvider.getAllEntries()
		subscriveToImageEntries()
    }
	
	private func subscriveToImageEntries() {
		storageProvider
			.observe()
			.sink(receiveValue: { values in
				self.moodEntries.insert(contentsOf: values, at: 0)
			})
			.store(in: &cancellable)
	}
    
}
