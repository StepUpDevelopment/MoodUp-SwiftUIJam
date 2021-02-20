//
//  TimelineView.swift
//  MoodUp
//
//  Created by Nicolas Spinner on 19.02.21.
//

import SwiftUI

struct TimelineView: View {

    @ObservedObject var viewModel: TimelineViewModel

    @State private var isShowingNewEntryView = false
    
    //TODO remove me
    @State private var entries = StorageProvider().getAllEntries()

    var body: some View {
		ZStack {
			LinearGradient.main
				.ignoresSafeArea()

            VStack {
                ScrollingWeekView()
                    .frame(height: 80)


                Spacer()
                ForEach(0 ..< entries.count) { index in
                    let currentEntry = entries[index]
                    currentEntry.moodType.icon
                }

                MainButton(buttonTitle: "add_mood", buttonAction: {
                    self.isShowingNewEntryView = true
                }).sheet(isPresented: $isShowingNewEntryView) {
                    NewEntryView(isShowingNewEntryView: self.$isShowingNewEntryView, storageProvider: viewModel.storageProvider)
                }
                .padding()
            }
		}
    }
}

struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView(viewModel: TimelineViewModel(storageProvider: .previewProvider))
    }
}
