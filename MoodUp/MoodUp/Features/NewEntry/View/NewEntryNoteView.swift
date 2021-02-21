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
        ZStack {
            LinearGradient.main
                .ignoresSafeArea()
            
            VStack {
                Text("Write down your feelings")
                    .font(.title)
                
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
    }
}

struct NewEntryNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NewEntryNoteView(viewModel: NewEntryViewModel(moodType: .excellent, storageProvider: .previewProvider))
    }
}
