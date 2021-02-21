//
//  TimelineCell.swift
//  MoodUp
//
//  Created by Nicolas Spinner on 20.02.21.
//

import SwiftUI

struct TimelineCell: View {
    
    var moodEntry: MoodEntry
    
    private var columns: [GridItem]
    
    init(moodEntry: MoodEntry) {
        self.moodEntry = moodEntry
        var columnCount = (Double(moodEntry.categories.count) / 2.0).rounded(.up)
        let maxColumnCount: Double = 3
        columnCount = min(columnCount, maxColumnCount)
        var columns: [GridItem] = []
        for _ in 0..<Int(columnCount) {
            columns.append(GridItem(.fixed(30), spacing: 8))
        }
        self.columns = columns
    }
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                HStack {
                    SmileyView(moodType: moodEntry.moodType)
                        .frame(width: 30, height: 30)
                    Text(LocalizedStringKey(moodEntry.moodType.titleKey))
                        .foregroundColor(.primary)
                        .font(.headline)
                }
                .padding(.bottom, 8)
                
                HStack {
                    Image(systemName: "clock")
                    Text(moodEntry.createdDate.relativeOrMediumString())
                        .fontWeight(.light)
                }
                .font(.subheadline)
                .foregroundColor(.primaryForegroundColor)
                
                if let moodText = moodEntry.text {
                    HStack {
                        Image(systemName: "pencil")
                        Text(moodText)
                            .fontWeight(.light)
                            .lineLimit(2)
                    }
                    .font(.subheadline)
                    .foregroundColor(.primaryForegroundColor)
                    .padding(.top, 8)
                }
            }
            
            Spacer()
            
            LazyVGrid(
                columns: columns,
                alignment: .trailing,
                spacing: 8
            ) {
                ForEach(moodEntry.categories) { category in
                    Image(category.iconName)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.secondaryBackground)
        .embedInCardView()
        .padding([.top, .leading, .trailing])
    }
    
}

struct TimelineCell_Previews: PreviewProvider {
    static var previews: some View {
        let moodEntry = MoodEntry(moodType: .excellent, categories: [
            MoodCategory(identifier: 1, title: "category_family", iconName: "CategoryFamily"),
            MoodCategory(identifier: 2, title: "category_money", iconName: "CategoryMoney"),
            MoodCategory(identifier: 3, title: "category_friends", iconName: "CategoryFriends")
        ], text: "Feeling good")
        return Group {
            TimelineCell(moodEntry: moodEntry)
                .previewLayout(.sizeThatFits)
                .padding()
            TimelineCell(moodEntry: moodEntry)
                .previewLayout(.sizeThatFits)
                .colorScheme(.dark)
                .padding()
        }
    }
}
