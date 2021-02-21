//
//  NewEntryNoteView.swift
//  MoodUp
//
//  Created by Nicolas Spinner on 21.02.21.
//

import SwiftUI

struct NewEntryNoteView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: NewEntryViewModel
    @State var noteText = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient.main
                        .ignoresSafeArea()

                VStack {

                    TextEditor(text: $noteText)

                    Spacer()

                    MainButton(buttonTitle: "save") {
                        viewModel.moodText = noteText
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .foregroundColor(.primaryForegroundColor)
                .padding()
            }
			.onAppear {
				noteText = viewModel.moodText
			}
            .navigationBarItems(trailing:
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("cancel")
                })
            )
            .navigationTitle("new_entry_note")
        }
    }
}

struct NewEntryNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NewEntryNoteView(viewModel: NewEntryViewModel(moodType: .excellent, storageProvider: .previewProvider))
    }
}
