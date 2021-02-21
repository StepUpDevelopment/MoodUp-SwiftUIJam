//
//  NewEntryMoodView.swift
//  MoodUp
//
//  Created by Nicolas Spinner on 19.02.21.
//

import SwiftUI

struct NewEntryMoodView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State private var isShowingNewEntryCategoryView = false
    @State private var selectedMood: MoodType?
    
    @Binding var isShowingNewEntryView: Bool
	
	var storageProvider: StorageProvider
	    
    var body: some View {
        NavigationView {
			ZStack {
                LinearGradient.main
                    .ignoresSafeArea()
                
                VStack {
                    Text("new_entry_title")
                        .foregroundColor(.primaryForegroundColor)
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
					if let selectedMood = selectedMood {
						NavigationLink(destination: NewEntryCategoryView(
                            isShowingNewEntryView: self.$isShowingNewEntryView, viewModel: NewEntryViewModel(moodType: selectedMood, storageProvider: storageProvider)
						), isActive: $isShowingNewEntryCategoryView) {}
					}
					
                    MainButton(buttonTitle: "continue") {
						if selectedMood != nil {
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
							self.isShowingNewEntryCategoryView = true
                        }
					}
                    .disabled(selectedMood == nil)
                    .padding()
                    
                    Spacer()
                }
				.navigationBarItems(trailing:
					Button(action: {
						isShowingNewEntryView = false
					}, label: {
						Text("cancel")
					})
				)
            }
        }
        .onOpenURL { url in
            /*if url.shouldHandleChoosenMood {
                self.isShowingNewEntryView = true
            }*/
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
        NewEntryMoodView(isShowingNewEntryView: .constant(true), storageProvider: StorageProvider(inMemory: true))
    }
}
