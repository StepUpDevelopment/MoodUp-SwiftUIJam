//
//  StorageProvider.swift
//  MoodUp
//
//  Created by Nicolas Spinner on 19.02.21.
//

import Foundation
import CoreData

class StorageProvider {

    private let persistentContainer: NSPersistentContainer
    
    static var previewProvider: StorageProvider = {
        let result = StorageProvider(inMemory: true)
        let viewContext = result.persistentContainer.viewContext
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
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
}

extension StorageProvider {
    
    func saveEntry(moodEntry: MoodEntry) {
        let _ = moodEntry.coreDataModel(context: persistentContainer.viewContext)

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
        
        do {
            let dbEntries = try persistentContainer.viewContext.fetch(fetchRequest)
            return dbEntries.map { $0.moodEntry() }
        } catch {
            print("Failed to fetch mood entries: \(error)")
            return []
        }
    }
    
}
