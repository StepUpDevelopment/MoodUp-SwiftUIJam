//
//  NewEntryCategoryView.swift
//  MoodUp
//
//  Created by Fabian Köbel on 20.02.21.
//

import SwiftUI

struct NewEntryCategoryView: View {
    @Binding var isShowingNewEntryView: Bool
    @ObservedObject var viewModel: NewEntryViewModel
    
    @State var inputText: String = NSLocalizedString("new_entry_category_input_placeholder", comment: "")
    @State var showNoteSheet = false

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient.main
                    .ignoresSafeArea()
                
                VStack {
                    Text(String(format: NSLocalizedString("new_entry_category_title", comment: ""),
                                viewModel.moodType.titleKey))
                        .foregroundColor(.primaryForegroundColor)
                        .font(.title)
                        .padding(.leading, 32)
                        .padding(.trailing, 32)
                        .multilineTextAlignment(.center)
                    
                    NewEntryCategoryGridView(entryViewModel: viewModel)
                    
                    Button(action: {
                        self.showNoteSheet = true
                    }, label: {
                        HStack {
                            Image("Edit")
                                .resizable()
                                .frame(width: 48, height: 48)
                                .foregroundColor(.primaryForegroundColor)
                                .padding(.leading, 8)
                            
                            Text(viewModel.moodText)
                                .padding(.top, 8)
                                .padding(.bottom, 8)
                                .foregroundColor(.primaryForegroundColor)
                                .font(.subheadline)
                            
                            Spacer()
                        }
                        .frame(width: geometry.size.width - 76, height: 68)
                        .background(Color.selectableButtonBackground)
                        .cornerRadius(8)
                    })
                      
                    MainButton(buttonTitle: "save") {
                        viewModel.save()
                        
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                        
                        isShowingNewEntryView = false
                    }
                    .padding()
                }
            }
            .sheet(isPresented: $showNoteSheet, content: {
                NewEntryNoteView(viewModel: viewModel)
            })
        }
    }
}

struct NewEntryCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        NewEntryCategoryView(isShowingNewEntryView: .constant(true), viewModel: NewEntryViewModel(moodType: .bad, storageProvider: StorageProvider(inMemory: true)))
    }
}
