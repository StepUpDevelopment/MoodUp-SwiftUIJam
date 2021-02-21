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
    @State var noteText = NSLocalizedString("new_entry_category_input_placeholder", comment: "")
	
    var body: some View {
		NavigationView {
			ZStack {
				LinearGradient.main
					.ignoresSafeArea()
				
				VStack {
					
					TextEditor(text: $noteText)
					
					Spacer()
				}
				.foregroundColor(.primaryForegroundColor)
				.padding()
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
