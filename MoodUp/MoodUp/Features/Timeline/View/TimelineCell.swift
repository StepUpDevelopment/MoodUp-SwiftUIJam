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
        let columnCount = (Double(moodEntry.categories.count) / 2.0).rounded(.up)
        var columns: [GridItem] = []
        for _ in 0..<Int(columnCount) {
            columns.append(GridItem(.fixed(30), spacing: 8))
        }
        self.columns = columns
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    HStack {
                        SmileyView(moodType: moodEntry.moodType)
                            .frame(width: 30, height: 30)
                        Text(moodEntry.moodType.titleKey)
                            .font(.headline)
                    }
                    .padding(.bottom, 8)
                    
                    HStack {
                        Image(systemName: "applewatch.watchface")
                        Text(moodEntry.createdDate.relativeOrMediumString())
                            .fontWeight(.light)
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
            
            if let moodText = moodEntry.text {
                HStack {
                    Image(systemName: "pencil.tip")
                    Text(moodText)
                        .fontWeight(.light)
                        .lineLimit(1)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.selectableButtonBackground)
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
        return TimelineCell(moodEntry: moodEntry)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
