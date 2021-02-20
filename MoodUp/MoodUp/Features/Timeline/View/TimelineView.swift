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
    
    var body: some View {
		ZStack {
			LinearGradient.main
				.ignoresSafeArea()

            VStack {
                ScrollingWeekView()
                    .frame(height: 80)

                ScrollView {
                    LazyVStack {
						ForEach(viewModel.sections) { section in
							Text(section.title)
							ForEach(section.items, id: \.self) { moodEntry in
								TimelineCell(moodEntry: moodEntry)
							}
						}
                    }
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
