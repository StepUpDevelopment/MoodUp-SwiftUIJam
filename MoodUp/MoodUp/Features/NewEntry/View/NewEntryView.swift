//
//  NewEntryView.swift
//  MoodUp
//
//  Created by Nicolas Spinner on 19.02.21.
//

import SwiftUI

struct NewEntryView: View {
    var body: some View {
        ZStack {
            LinearGradient.main
                .ignoresSafeArea()
            
            VStack {
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
            }
        }
    }
    
    private func moodButton(moodType: MoodType, title: String) -> some View {
        Button(action: {
            print("aassd")
        }, label: {
            VStack {
                SmileyView(moodType: moodType)
                Text(title)
                    .foregroundColor(.primaryForegroundColor)
            }
        })
        .buttonStyle(SelectableButtonStyle())
    }
}

struct SelectableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(configuration.isPressed ? .gray : .white)
            .padding()
            .background(Color.selectableButtonBackground)
            .cornerRadius(8)
            .frame(width: 100, height: 120)
    }
}
struct NewEntryView_Previews: PreviewProvider {
    static var previews: some View {
        NewEntryView()
    }
}
