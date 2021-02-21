//
//  MoodEntryDetailView.swift
//  MoodUp
//
//  Created by Nicolas Spinner on 21.02.21.
//

import SwiftUI

struct MoodEntryDetailView: View {
    
    var moodEntry: MoodEntry
    
    var body: some View {
        ZStack {
            LinearGradient.main
                .ignoresSafeArea()
            
            
        }
    }
}

struct MoodEntryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MoodEntryDetailView(moodEntry: MoodEntry(moodType: .good))
    }
}
