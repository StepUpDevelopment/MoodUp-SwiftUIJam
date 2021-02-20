//
//  NewEntryCategoryView.swift
//  MoodUp
//
//  Created by Fabian Köbel on 20.02.21.
//

import SwiftUI

struct NewEntryCategoryView: View {
    @Binding var isShowingNewEntryView: Bool
    
    @State var inputText: String = NSLocalizedString("new_entry_category_input_placeholder", comment: "")
    
    @ObservedObject var viewModel: NewEntryCategoryViewModel

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient.main
                    .ignoresSafeArea()
                
                VStack {
                    Text("new_entry_category_title")
                        .foregroundColor(.primaryForegroundColor)
                        .font(.title)
                        .padding(.leading, 32)
                        .padding(.trailing, 32)
                        .multilineTextAlignment(.center)
                    
                    NewEntryCategoryGridView(entryViewModel: viewModel)
                    
                    HStack {
                        Image("Edit")
                            .resizable()
                            .frame(width: 48, height: 48)
                            .foregroundColor(.primaryForegroundColor)
                            .padding(.leading, 8)
                        
                        TextEditor(text: $inputText)
                            .padding(.top, 8)
                            .padding(.bottom, 8)
                            .accentColor(.primaryForegroundColor)
                            .foregroundColor(.primaryForegroundColor)
                            .font(.subheadline)
                            .background(Color.selectableButtonBackground)
                            .cornerRadius(8)
                            .onTapGesture {
                                if self.inputText == NSLocalizedString("new_entry_category_input_placeholder", comment: "") {
                                    self.inputText = ""
                                }
                            }
                    }
                    .frame(width: geometry.size.width - 76, height: 68)
                        .background(Color.selectableButtonBackground)
                      
                    MainButton(buttonTitle: "save") {
                        viewModel.moodText = self.inputText
                        viewModel.save()
                        isShowingNewEntryView = false
                    }
                    .padding()
                }
            }
        }
    }
}

struct NewEntryCategoryGridView: View {
    @ObservedObject var entryViewModel: NewEntryCategoryViewModel
    
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
    @ObservedObject var entryViewModel: NewEntryCategoryViewModel
    
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

struct NewEntryCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        NewEntryCategoryView(isShowingNewEntryView: .constant(true), viewModel: NewEntryCategoryViewModel(moodType: .bad, storageProvider: StorageProvider(inMemory: true)))
    }
}
