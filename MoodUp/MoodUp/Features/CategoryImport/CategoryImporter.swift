//
//  CategoryImporter.swift
//  MoodUp
//
//  Created by Manuel Kunz on 20.02.21.
//

import Foundation

class CategoryImporter {
	
	private var storageProvider: StorageProvider
	
	init(storageProvider: StorageProvider? = nil) {
		self.storageProvider = storageProvider ?? StorageProvider()
	}
	
	func parseImportJson() -> [CategoryJsonModel] {
		
		guard let url =  Bundle.main.url(forResource: "Categories", withExtension: "json") else {
			return []
		}
					
		var categoryJsonModel: [CategoryJsonModel]?
		do {
			let data = try Data(contentsOf: url)
			categoryJsonModel = try JSONDecoder().decode([CategoryJsonModel].self, from: data)
		} catch {
			print("Could not parse json")
		}
		return categoryJsonModel ?? []
		
	}
			
	func importCategories(_ categories: [CategoryJsonModel]) {
		categories.forEach { model in
			storageProvider.saveCategory(categoryJsonModel: model)
		}
	}
}
