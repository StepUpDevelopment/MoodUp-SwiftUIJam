//
//  NewEntryCategoryView.swift
//  MoodUp
//
//  Created by Fabian Köbel on 20.02.21.
//

import SwiftUI

struct NewEntryCategoryView: View {

	@ObservedObject var viewModel: NewEntryCategoryViewModel

    var body: some View {
        ZStack {
            LinearGradient.main
                .ignoresSafeArea()
            
            VStack {
                Text("new_entry_category_title")
                    .font(.title)
                    .padding()
                NewEntryCategoryGridView(entryViewModel: viewModel)
                Spacer()
                MainButton(buttonTitle: "save_mood") {
                    print("Save Mood")
                }
                .padding()
            }
        }
    }
}

struct NewEntryCategoryGridView: View {
    @ObservedObject var entryViewModel: NewEntryCategoryViewModel
    
    var columns: [GridItem] = [
            GridItem(.fixed(100), spacing: 16),
            GridItem(.fixed(100), spacing: 16),
            GridItem(.fixed(100), spacing: 16)
        ]

    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: columns,
                alignment: .center,
                spacing: 16
            ) {
                ForEach(entryViewModel.moodCategories) { category in
                    NewEntryCategoryGridItemView(category: category)
                }
            }
        }
    }
}

struct NewEntryCategoryGridItemView: View {
    var category: MoodCategory
    @State var isCategorySelected: Bool = false

    var body: some View {
        VStack {
            Button(action: {
                isCategorySelected = !isCategorySelected
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

struct NewEntryCategoryView_Previews: PreviewProvider {
    static var previews: some View {
		NewEntryCategoryView(viewModel: NewEntryCategoryViewModel(moodType: .bad, storageProvider: StorageProvider(inMemory: true)))
    }
}
