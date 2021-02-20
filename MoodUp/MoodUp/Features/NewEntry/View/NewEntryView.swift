//
//  NewEntryView.swift
//  MoodUp
//
//  Created by Nicolas Spinner on 19.02.21.
//

import SwiftUI

struct NewEntryView: View {
    
    @State var selectedMoods: Set<MoodType> = []
    
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
                    moodButton(moodType: .awful, title: "Awful")
                    moodButton(moodType: .bad, title: "Bad")
                }
                HStack {
                    moodButton(moodType: .meh, title: "Meh")
                    moodButton(moodType: .okay, title: "Okay")
                    moodButton(moodType: .good, title: "Good")
                }
                HStack {
                    moodButton(moodType: .great, title: "Great")
                    moodButton(moodType: .excellent, title: "Excellent")
                }
                Spacer()
                MainButton(buttonTitle: "continue") {
                    print("Show Categories")
                }
            }
        }
    }
    
    private func moodButton(moodType: MoodType, title: String) -> some View {
        Button(action: {
            if selectedMoods.contains(moodType) {
                selectedMoods.remove(moodType)
            } else {
                selectedMoods.insert(moodType)
            }
        }, label: {
            VStack {
                SmileyView(moodType: moodType)
                Text(title)
            }
        })
        .buttonStyle(SelectableButtonStyle(isSelected: selectedMoods.contains(moodType)))
    }
}

struct NewEntryView_Previews: PreviewProvider {
    static var previews: some View {
        NewEntryView()
    }
}
