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
            
            VStack {
                HStack {
                    SmileyView(moodType: moodEntry.moodType)
                        .frame(width: 50, height: 50)
                    Text(LocalizedStringKey(moodEntry.moodType.titleKey))
                        .foregroundColor(.primary)
                        .font(.title)
                        .fontWeight(.medium)
                }
                Spacer()
            }
        }.navigationBarTitle("", displayMode: .inline)
    }
}

struct MoodEntryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MoodEntryDetailView(moodEntry: MoodEntry(moodType: .good))
    }
}
