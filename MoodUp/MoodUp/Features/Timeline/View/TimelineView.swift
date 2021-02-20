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
                        ForEach(viewModel.moodEntries, id: \.self) { moodEntry in
                            TimelineCell(moodEntry: moodEntry)
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

struct TimelineCell: View {
    
    var moodEntry: MoodEntry
    
    private var columns: [GridItem]
    
    init(moodEntry: MoodEntry) {
        self.moodEntry = moodEntry
        let columnCount = (Double(moodEntry.categories.count) / 2.0).rounded(.up)
        var columns: [GridItem] = []
        for _ in 0..<Int(columnCount) {
            columns.append(GridItem(.fixed(30), spacing: 8))
        }
        self.columns = columns
    }
    
    var body: some View {
        HStack {
            Text(moodEntry.moodType.titleKey)
            
            Spacer()
            
            LazyVGrid(
                columns: columns,
                alignment: .center,
                spacing: 8
            ) {
                ForEach(moodEntry.categories) { category in
					Image(category.iconName)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.selectableButtonBackground)
        .embedInCardView()
        .padding([.top, .leading, .trailing])
    }
    
}

struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView(viewModel: TimelineViewModel(storageProvider: .previewProvider))
    }
}
