//
//  MoodEntryDetailCategoryGridView.swift
//  MoodUp
//
//  Created by Nicolas Spinner on 21.02.21.
//

import SwiftUI

struct MoodEntryDetailCategoryGridItemView: View {
    
    var category: MoodCategory
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
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
            .background(Color.secondaryBackground)
            .embedInCardView()
        }
    }
}

struct MoodEntryDetailCategoryGridView_Previews: PreviewProvider {
    static var previews: some View {
        MoodEntryDetailCategoryGridItemView(category:
            MoodCategory(identifier: 1, title: "category_family", iconName: "CategoryFamily")
            )
    }
}
