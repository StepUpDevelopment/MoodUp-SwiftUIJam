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
	
	func testReadCategoriesJson() throws {
		
		let storageProvider = StorageProvider(inMemory: true)
		let categoryImporter = CategoryImporter(storageProvider: storageProvider)
		let results = categoryImporter.parseImportJson()
		XCTAssertEqual(results.count, 7)
	}
	
	func testImportCategoryModelToDB() {
		
		let storageProvider = StorageProvider(inMemory: true)
		let categoryImporter = CategoryImporter(storageProvider: storageProvider)
		let jsonCategories = categoryImporter.parseImportJson()
		XCTAssertEqual(jsonCategories.count, 7)
		categoryImporter.importCategories(jsonCategories)
		let moodCategories = storageProvider.getAllCategories()
		XCTAssertEqual(moodCategories.count, 7)
		
		categoryImporter.importCategories(jsonCategories)
		let moodCategoriesCount = storageProvider.getAllCategories().count
		XCTAssertEqual(moodCategoriesCount, 7)
				
	}
	
}
