//
//  NewEntryView.swift
//  MoodUp
//
//  Created by Nicolas Spinner on 19.02.21.
//

import SwiftUI

struct NewEntryView: View {
    
    @State var selectedMood: MoodType?
    
    var body: some View {
        ZStack {
            LinearGradient.main
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("new_entry_title")
                    .font(.title)
                    .padding()
                HStack {
                    moodButton(moodType: .awful, title: "awful")
                    moodButton(moodType: .bad, title: "bad")
                }
                HStack {
                    moodButton(moodType: .meh, title: "meh")
                    moodButton(moodType: .okay, title: "okay")
                    moodButton(moodType: .good, title: "good")
                }
                HStack {
                    moodButton(moodType: .great, title: "great")
                    moodButton(moodType: .excellent, title: "excellent")
                }
                Spacer()
                MainButton(buttonTitle: "continue") {
                    print("Show Categories")
                }
                .padding()
            }
        }
    }
    
    private func moodButton(moodType: MoodType,
                            title: LocalizedStringKey) -> some View {
        Button(action: {
            selectedMood = moodType
        }, label: {
            VStack {
                SmileyView(moodType: moodType)
                Text(title)
            }
        })
        .buttonStyle(SelectableButtonStyle(isSelected: moodType == selectedMood))
    }
}

struct NewEntryView_Previews: PreviewProvider {
    static var previews: some View {
        NewEntryView()
    }
}
