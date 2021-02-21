//
//  NewEntryNoteView.swift
//  MoodUp
//
//  Created by Nicolas Spinner on 21.02.21.
//

import SwiftUI

struct NewEntryNoteView: View {
    
    @ObservedObject var viewModel: NewEntryViewModel
    @State var noteText = NSLocalizedString("new_entry_category_input_placeholder", comment: "")
    
    var body: some View {
        ZStack {
            LinearGradient.main
                .ignoresSafeArea()
            
            VStack {
                Text("Write down your feelings")
                    .font(.title)
                
                TextEditor(text: $noteText)
                
                Spacer()
            }
            .foregroundColor(.primaryForegroundColor)
            .padding()
        }
    }
}

struct NewEntryNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NewEntryNoteView(viewModel: NewEntryViewModel(moodType: .excellent, storageProvider: .previewProvider))
    }
}
