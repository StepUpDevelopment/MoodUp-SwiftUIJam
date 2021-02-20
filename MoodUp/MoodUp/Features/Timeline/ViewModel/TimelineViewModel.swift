//
//  TimelineViewModel.swift
//  MoodUp
//
//  Created by Nicolas Spinner on 20.02.21.
//

import Foundation
import SwiftUI

class TimelineViewModel: ObservableObject {
    
    let storageProvider: StorageProvider
    @Published var moodEntries: [MoodEntry] = []
    
    init(storageProvider: StorageProvider) {
        self.storageProvider = storageProvider
        moodEntries = storageProvider.getAllEntries()
    }    
    
}
