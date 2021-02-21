//
//  StatsViewModel.swift
//  MoodUp
//
//  Created by Manuel Kunz on 20.02.21.
//

import Foundation

class StatsViewModel: ObservableObject {
	
	private var storageProvider: StorageProvider
	
	init(storageProvider: StorageProvider) {
		self.storageProvider = storageProvider		
	}
	
	func calculateStatistics() {
		categorieStatistics.removeAll()
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
				categorieStatistics.append(CategoryStatistic(moodCategory: category, moodTypeValues: moodTypes))
			}
		}
	}
	
	@Published var categorieStatistics: [CategoryStatistic] =
	    [
//			CategoryStatistic(moodCategory: MoodCategory(identifier: 1, title: "Food", iconName: "CategoryFood"), moodTypeValues: [
//				MoodTypeValue(type: .bad, value: 10),
//				MoodTypeValue(type: .awful, value: 5),
//				MoodTypeValue(type: .excellent, value: 25),
//				MoodTypeValue(type: .great, value: 25),
//				MoodTypeValue(type: .meh, value: 80)
//			]),
//			CategoryStatistic(moodCategory: MoodCategory(identifier: 2, title: "Food", iconName: "CategoryFood"), moodTypeValues: [
//				MoodTypeValue(type: .bad, value: 10),
//				MoodTypeValue(type: .awful, value: 5),
//				MoodTypeValue(type: .excellent, value: 25),
//				MoodTypeValue(type: .great, value: 25),
//				MoodTypeValue(type: .meh, value: 80)
//			]),
//			CategoryStatistic(moodCategory: MoodCategory(identifier: 3, title: "Food", iconName: "CategoryFood"), moodTypeValues: [
//				MoodTypeValue(type: .bad, value: 10),
//				MoodTypeValue(type: .awful, value: 5),
//				MoodTypeValue(type: .excellent, value: 25),
//				MoodTypeValue(type: .great, value: 25),
//				MoodTypeValue(type: .meh, value: 80)
//			]),
//			CategoryStatistic(moodCategory: MoodCategory(identifier: 4, title: "Food", iconName: "CategoryFood"), moodTypeValues: [
//				MoodTypeValue(type: .bad, value: 10),
//				MoodTypeValue(type: .awful, value: 5),
//				MoodTypeValue(type: .excellent, value: 25),
//				MoodTypeValue(type: .great, value: 25),
//				MoodTypeValue(type: .meh, value: 80)
//			])
		]
	
	
}

struct CategoryStatistic : Hashable, Equatable{
	static func == (lhs: CategoryStatistic, rhs: CategoryStatistic) -> Bool {
		lhs.moodCategory.id == rhs.moodCategory.id
	}
	
	var moodCategory: MoodCategory
	var moodTypeValues: [MoodTypeValue]
	func hash(into hasher: inout Hasher) {
		hasher.combine(moodCategory.id)
	}
}
