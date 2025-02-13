//
//  StorageProvider.swift
//  MoodUp
//
//  Created by Nicolas Spinner on 19.02.21.
//

import Foundation
import CoreData
import Combine

class StorageProvider {

    private let persistentContainer: NSPersistentContainer
	
	private var moodEntryPublisher: PassthroughSubject<[MoodEntry], Never>?
    
    static var previewProvider: StorageProvider = {
        let result = StorageProvider(inMemory: true)
        let viewContext = result.persistentContainer.viewContext
        let moodEntry = MoodEntry(moodType: .excellent, categories: [
            MoodCategory(identifier: 1, title: "category_family", iconName: "CategoryFamily"),
            MoodCategory(identifier: 2, title: "category_money", iconName: "CategoryMoney"),
            MoodCategory(identifier: 3, title: "category_friends", iconName: "CategoryFriends")
        ])
        result.saveEntry(moodEntry: moodEntry)
        let secondMoodEntry = MoodEntry(moodType: .bad, categories: [MoodCategory(identifier: 2, title: "category_money", iconName: "CategoryMoney")])
        result.saveEntry(moodEntry: secondMoodEntry)
        return result
    }()

    init(inMemory: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "MoodUp")
        if inMemory {
            persistentContainer.persistentStoreDescriptions[0].url = URL(fileURLWithPath: "/dev/null")
        }

        persistentContainer.loadPersistentStores(completionHandler: { description, error in
            if let error = error {
                fatalError("Core Data store failed to load with error: \(error)")
            }
        })
    }
	
	
	func observe() -> AnyPublisher<[MoodEntry], Never> {
		if moodEntryPublisher == nil {
			moodEntryPublisher = PassthroughSubject<[MoodEntry], Never>()
			let managedObjectContext = persistentContainer.viewContext
			let notificationCenter = NotificationCenter.default
			notificationCenter.addObserver(
				self,
				selector: #selector(managedObjectContextObjectsDidChange),
				name: NSNotification.Name.NSManagedObjectContextObjectsDidChange,
				object: managedObjectContext)			
		}
		return moodEntryPublisher!.eraseToAnyPublisher()
		
	}
	
	@objc func managedObjectContextObjectsDidChange(notification: NSNotification) {
		guard let userInfo = notification.userInfo else { return }

		if let inserts = userInfo[NSInsertedObjectsKey] as? Set<NSManagedObject>, inserts.count > 0 {

			if let castedInserts = inserts as? Set<DbMoodEntry> {
				moodEntryPublisher?.send(
					Array(castedInserts).map { $0.moodEntry() }
				)
			}
		}
	}
}

extension StorageProvider {
    
    func saveEntry(moodEntry: MoodEntry) {
        let dbMoodEntry = moodEntry.coreDataModel(context: persistentContainer.viewContext)
		dbMoodEntry.categories =
			NSSet(array:
					moodEntry.categories.compactMap { category(forIdentifier: $0.identifier) }
			)
		
        do {
            try persistentContainer.viewContext.save()
            print("Mood entry saved succesfully")
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save mood entry: \(error)")
        }
    }
    
    func getAllEntries() -> [MoodEntry] {
        let fetchRequest: NSFetchRequest<DbMoodEntry> = DbMoodEntry.fetchRequest()
		let descendingSortDescriptor = NSSortDescriptor(key: "createdDate", ascending: false)
		fetchRequest.sortDescriptors = [descendingSortDescriptor]
        
        do {
            let dbEntries = try persistentContainer.viewContext.fetch(fetchRequest)
            return dbEntries.map { $0.moodEntry() }
        } catch {
            print("Failed to fetch mood entries: \(error)")
            return []
        }
    }
	
	func saveCategory(moodCategory: MoodCategory) {
		

		let category = self.category(forIdentifier: moodCategory.identifier) ??
			DbMoodCategory(
				entity: NSEntityDescription.entity(forEntityName: DbMoodCategory.className,
												   in: persistentContainer.viewContext)!,
				insertInto: persistentContainer.viewContext)
				
		category.identifier = Int64(moodCategory.identifier)
		category.title = moodCategory.title
		category.iconName = moodCategory.iconName
		
		do {
			try persistentContainer.viewContext.save()
			print("Mood category saved succesfully")
		} catch {
			persistentContainer.viewContext.rollback()
			print("Failed to save mood category: \(error)")
		}
	}
	
	func getAllCategories() -> [MoodCategory] {
		let fetchRequest: NSFetchRequest<DbMoodCategory> = DbMoodCategory.fetchRequest()
		
		do {
			let dbCategories = try persistentContainer.viewContext.fetch(fetchRequest)
			return dbCategories.map { $0.moodCategory() }
		} catch {
			print("Failed to fetch mood entries: \(error)")
			return []
		}
	}
	
	private func category(forIdentifier identifier: Int) -> DbMoodCategory? {
		
		let fetchRequest: NSFetchRequest<DbMoodCategory> = DbMoodCategory.fetchRequest()
		let predicate = NSPredicate(format: "identifier = %d", Int64(identifier))
		fetchRequest.entity = NSEntityDescription.entity(
			forEntityName: DbMoodCategory.className,
			in: persistentContainer.viewContext
		)
		fetchRequest.predicate = predicate
		
		do {
			let dbCategory = try persistentContainer.viewContext.fetch(fetchRequest).first
			return dbCategory
		} catch {
			print("Failed to fetch mood category: \(error)")
			return nil
		}
	}
}
