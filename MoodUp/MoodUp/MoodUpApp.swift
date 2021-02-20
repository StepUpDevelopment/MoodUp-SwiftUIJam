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
	}
    var body: some Scene {
        WindowGroup {
            TabBarView()
        }
    }
}
