//
//  CategoryImporter.swift
//  MoodUp
//
//  Created by Manuel Kunz on 20.02.21.
//

import Foundation
import CryptoKit

class CategoryImporter {
	
	private var storageProvider: StorageProvider
	private let userDefaultsKey = "CategoriesImportHash"
	
	init(storageProvider: StorageProvider? = nil) {
		self.storageProvider = storageProvider ?? StorageProvider()
	}
	
	func execute() {
		
		guard let fileData = importJsonData() else {
			preconditionFailure("No Categories.json was provided or the json was invalid")
		}		
		
		let fileHash = SHA256.hash(data: fileData).hashString
		
		let persistedHash = UserDefaults.standard.string(forKey: userDefaultsKey)
		
		if persistedHash != nil {
			if persistedHash == fileHash {
				print("Category Json does not differ from previous json, will not import new categories")
				return
			}
			print("Category hash differs from saved category hash")
		}
		
		print("Import new Categories")
		
		importCategories(parseImportJson(data: fileData))
		
		UserDefaults.standard.set(fileHash, forKey: userDefaultsKey)
	}
	
	private func importJsonData() -> Data? {
		guard let url =  Bundle.main.url(forResource: "Categories", withExtension: "json") else {
			return nil
		}
		
		return try? Data(contentsOf: url)
	}
	
	private func parseImportJson(data: Data) -> [MoodCategory] {
							
		var categoryJsonModel: [MoodCategory]?
		do {
			categoryJsonModel = try JSONDecoder().decode([MoodCategory].self, from: data)
		} catch {
			print("Could not parse json")
		}
		return categoryJsonModel ?? []
		
	}
			
	private func importCategories(_ categories: [MoodCategory]) {
		categories.forEach { model in
			storageProvider.saveCategory(moodCategory: model)
		}
	}
}
