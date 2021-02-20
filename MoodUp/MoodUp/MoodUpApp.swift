//
//  MoodUpApp.swift
//  MoodUp
//
//  Created by Nicolas Spinner on 19.02.21.
//

import SwiftUI

@main
struct MoodUpApp: App {
    
    let storageProvider = StorageProvider()
    
    init() {
        CategoryImporter().execute()
        UINavigationBar.appearance().tintColor = UIColor(Color.primaryForegroundColor)
//        mockEntries()
    }

    var body: some Scene {
        WindowGroup {
            TabBarView(storageProvider: storageProvider)
        }
    }
    
    private func mockEntries() {
        for index in -30..<0 {
            let day = Calendar.current.date(byAdding: .day, value: index, to: Date())!
            let moodEntry = MoodEntry(moodType: .excellent, categories: [
                MoodCategory(identifier: 1, title: "category_family", iconName: "CategoryFamily"),
                MoodCategory(identifier: 2, title: "category_money", iconName: "CategoryMoney"),
                MoodCategory(identifier: 3, title: "category_friends", iconName: "CategoryFriends")
            ], createdDate: day)
            storageProvider.saveEntry(moodEntry: moodEntry)
        }
    }
}
