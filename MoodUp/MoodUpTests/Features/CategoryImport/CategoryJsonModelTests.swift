//
//  CategoryJsonModelTests.swift
//  MoodUpTests
//
//  Created by Manuel Kunz on 20.02.21.
//

import Foundation
import XCTest

@testable import MoodUp
class CategoryJsonModelTests : MoodUpTests {
	
	func testImportCategoryModelToDB() {
		UserDefaults.standard.removeObject(forKey: "CategoriesImportHash")
		let storageProvider = StorageProvider(inMemory: true)
		let categoryImporter = CategoryImporter(storageProvider: storageProvider)
		categoryImporter.execute()

		let moodCategories = storageProvider.getAllCategories()
		XCTAssertEqual(moodCategories.count, 7)
		
		categoryImporter.execute()
		categoryImporter.execute()
		categoryImporter.execute()
		
		let moodCategoriesCount = storageProvider.getAllCategories().count
		XCTAssertEqual(moodCategoriesCount, 7)
		UserDefaults.standard.removeObject(forKey: "CategoriesImportHash")
				
	}
	
}
