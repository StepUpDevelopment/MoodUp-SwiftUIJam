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
	@Published var categorieStatistics: [CategoryStatistic] = []
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
			let results = Dictionary(grouping: category.moodCategories ?? [], by: { (element: MoodEntry) in
				return element.moodType
			})
			var moodTypes: [MoodTypeValue] = []
			results.keys.forEach { key in
				moodTypes.append(MoodTypeValue(type: key, value: Double(results[key]!.count)))
			}
			if !moodTypes.isEmpty {
				localStatistics.append(CategoryStatistic(moodCategory: category, moodTypeValues: moodTypes))
			}
		}
		categorieStatistics = localStatistics
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
