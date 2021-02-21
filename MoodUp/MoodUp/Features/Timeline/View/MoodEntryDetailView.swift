//
//  MoodEntryDetailView.swift
//  MoodUp
//
//  Created by Nicolas Spinner on 21.02.21.
//

import SwiftUI

struct MoodEntryDetailView: View {
    
    var moodEntry: MoodEntry
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            LinearGradient.main
                .ignoresSafeArea()
            
            ScrollView {
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
                    
                    LazyVGrid(
                        columns: columns,
                        alignment: .center,
                        spacing: 8
                    ) {
                        ForEach(moodEntry.categories) { category in
                            NavigationLink(
                                destination: CategoryStatsView(category: category),
                                label: {
                                    MoodEntryDetailCategoryGridItemView(category: category)
                                })
                        }
                    }
                    .padding([.leading, .trailing], 30)
                    .padding(.bottom, 16)
                    
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
            }
        }.navigationBarTitle("", displayMode: .inline)
    }
    
}

struct MoodEntryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MoodEntryDetailView(moodEntry: MoodEntry(moodType: .good, categories: [
             MoodCategory(identifier: 1, title: "category_family", iconName: "CategoryFamily"),
             MoodCategory(identifier: 2, title: "category_money", iconName: "CategoryMoney"),
             MoodCategory(identifier: 3, title: "category_friends", iconName: "CategoryFriends"),
            MoodCategory(identifier: 4, title: "category_mountains", iconName: "CategoryMountains")
         ], text: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. "))
    }
}
