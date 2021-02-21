//
//  NewEntryCategoryGridView.swift
//  MoodUp
//
//  Created by Nicolas Spinner on 21.02.21.
//

import SwiftUI

struct NewEntryCategoryGridView: View {
    @ObservedObject var entryViewModel: NewEntryViewModel
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: columns,
                alignment: .center,
                spacing: 16
            ) {
                ForEach(entryViewModel.moodCategories) { category in
                    NewEntryCategoryGridItemView(entryViewModel: entryViewModel, category: category)
                }
            }
            .padding(.leading, 32)
            .padding(.trailing, 32)
        }
    }
}

struct NewEntryCategoryGridItemView: View {
    @ObservedObject var entryViewModel: NewEntryViewModel
    
    @State var isCategorySelected: Bool = false

    var category: MoodCategory

    var body: some View {
        VStack {
            Button(action: {
                isCategorySelected = !isCategorySelected
                
                if let index = entryViewModel.selectedMoodCategories.firstIndex(of: category) {
                    entryViewModel.selectedMoodCategories.remove(at: index)
                }
                
                if (isCategorySelected) {
                    entryViewModel.selectedMoodCategories.append(category)
                }
            }, label: {
                VStack {
                    Image(category.iconName)
                        .resizable()
                        .frame(width: 64.0, height: 64.0)
                    Text(LocalizedStringKey(category.title))
                        .font(.caption)
                }
            })
            .buttonStyle(SelectableButtonStyle(isSelected: isCategorySelected))
        }
    }
}

struct NewEntryCategoryGridView_Previews: PreviewProvider {
    static var previews: some View {
        NewEntryCategoryGridView(entryViewModel: NewEntryViewModel(moodType: .good, storageProvider: .previewProvider))
    }
}
