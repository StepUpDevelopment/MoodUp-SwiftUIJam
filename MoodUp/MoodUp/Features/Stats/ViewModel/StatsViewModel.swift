//
//  StatsViewModel.swift
//  MoodUp
//
//  Created by Manuel Kunz on 20.02.21.
//

import Foundation
import Combine

class StatsViewModel: ObservableObject {
	
	private var storageProvider: StorageProvider
	@Published var categoryStatistics: [CategoryStatistic] = []
	private var cancellable = Set<AnyCancellable>()
	
	init(storageProvider: StorageProvider) {
		self.storageProvider = storageProvider
		calculateStatistics()
		observeEntries()
	}
	
	func observeEntries() {
		storageProvider
			.observe()
			.sink(receiveValue: { _ in
				self.calculateStatistics()
			})
			.store(in: &cancellable)
	}
	
	func calculateStatistics() {
		
		var localStatistics: [CategoryStatistic] = []
		let categories = storageProvider.getAllCategories()
		categories.forEach { category in
            if let categoryStatistic = category.statistic {
				localStatistics.append(categoryStatistic)
			}
		}
		categoryStatistics = localStatistics
	}
    
}

struct CategoryStatistic :  Identifiable {
	var id = UUID()
	var moodCategory: MoodCategory
	var moodTypeValues: [MoodTypeValue]
//	func hash(into hasher: inout Hasher) {
//		hasher.combine(moodCategory.id)
//	}
}
