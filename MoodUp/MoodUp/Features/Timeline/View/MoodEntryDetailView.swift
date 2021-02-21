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
                HStack(spacing: 16) {
                    SmileyView(moodType: moodEntry.moodType)
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text(LocalizedStringKey(moodEntry.moodType.titleKey))
                            .foregroundColor(.primaryForegroundColor)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(moodEntry.createdDate.mediumAndTimeString())
                    }
                }
                .padding()
                
                if let moodNote = moodEntry.text {
                    HStack {
                        Text(moodNote)
                            .padding()
                    }
                    .background(Color.secondaryBackground)
                    .embedInCardView()
                    .padding([.leading, .trailing], 30)
                }
                
                Spacer()
            }
        }.navigationBarTitle("", displayMode: .inline)
    }
    
}

struct MoodEntryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MoodEntryDetailView(moodEntry: MoodEntry(moodType: .good, text: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. "))
    }
}
