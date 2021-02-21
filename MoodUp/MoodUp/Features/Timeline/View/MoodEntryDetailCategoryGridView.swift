//
//  MoodEntryDetailCategoryGridView.swift
//  MoodUp
//
//  Created by Nicolas Spinner on 21.02.21.
//

import SwiftUI

struct MoodEntryDetailCategoryGridView: View {
    
    var categories: [MoodCategory]
    
    var categorySelectedAction: (MoodCategory) -> Void
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(
            columns: columns,
            alignment: .center,
            spacing: 8
        ) {
            ForEach(categories) { category in
                VStack {
                    Button(action: {
                        categorySelectedAction(category)
                    }, label: {
                        HStack {
                            Spacer()
                            VStack {
                                Image(category.iconName)
                                    .resizable()
                                    .frame(width: 64.0, height: 64.0)
                                Text(LocalizedStringKey(category.title))
                                    .foregroundColor(.primaryForegroundColor)
                                    .font(.caption)
                            }
                            .padding([.top, .bottom])
                            Spacer()
                        }
                    })
                    .background(Color.secondaryBackground)
                    .embedInCardView()
                }
            }
        }
        .padding([.leading, .trailing], 30)
        .padding(.bottom, 16)
    }
}

struct MoodEntryDetailCategoryGridView_Previews: PreviewProvider {
    static var previews: some View {
        MoodEntryDetailCategoryGridView(categories: [
            MoodCategory(identifier: 1, title: "category_family", iconName: "CategoryFamily"),
            MoodCategory(identifier: 2, title: "category_money", iconName: "CategoryMoney"),
            MoodCategory(identifier: 3, title: "category_friends", iconName: "CategoryFriends"),
           MoodCategory(identifier: 4, title: "category_mountains", iconName: "CategoryMountains")
        ], categorySelectedAction: { _ in })
    }
}
