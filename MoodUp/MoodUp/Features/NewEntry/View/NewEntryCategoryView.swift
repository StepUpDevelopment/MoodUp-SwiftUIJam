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
				ForEach(viewModel.moodCategories) { category in
					Text(category.title)
				}
                Spacer()
                Text("new_entry_category_title")
                    .font(.title)
                    .padding()
                NewEntryCategoryGridView()
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
    private var columns: [GridItem] = [
            GridItem(.fixed(100), spacing: 16),
            GridItem(.fixed(50), spacing: 16),
            GridItem(.fixed(100), spacing: 16)
        ]

    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: columns,
                alignment: .center,
                spacing: 16
            ) {
                ForEach(0...100, id: \.self) { index in
                    NewEntryCategoryGridItemView(gridIndex: index)
                }
            }
        }
    }
}

struct NewEntryCategoryGridItemView: View {
    var gridIndex: Int

    var body: some View {
        Text("abc \(gridIndex)")
    }
}

struct NewEntryCategoryView_Previews: PreviewProvider {
    static var previews: some View {
		NewEntryCategoryView(viewModel: NewEntryCategoryViewModel(moodType: .bad, storageProvider: StorageProvider(inMemory: true)))
    }
}
