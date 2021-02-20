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
    
    @State private var scrollTarget: MoodEntry?
    
    var body: some View {
		ZStack {
			LinearGradient.main
				.ignoresSafeArea()

            VStack {
                ScrollingWeekView { dayItem in
                    handleDaySelected(dayItem: dayItem)
                }
                .frame(height: 80)

                ScrollView {
                    ScrollViewReader { reader in
                        LazyVStack {
                            ForEach(viewModel.moodEntries, id: \.self) { moodEntry in
                                TimelineCell(moodEntry: moodEntry)
                            }
                        }
                        .onChange(of: scrollTarget) { value in
                            if let targetEntry = scrollTarget {
                                scrollTarget = nil
                                withAnimation {
                                    reader.scrollTo(targetEntry, anchor: .top)
                                }
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
    
    private func handleDaySelected(dayItem: DayItem) {
        let selectedDate = Date(timeIntervalSince1970: dayItem.timestamp)
        let firstEntry = viewModel.moodEntries.last { moodEntry in
            let calendar = Calendar.current
            let entryDateComponents = calendar.dateComponents([.day, .month, .year], from: moodEntry.createdDate)
            let selectedDateComponents = calendar.dateComponents([.day, .month, .year], from: selectedDate)
            guard let entryDay = entryDateComponents.day,
                  let entryMonth = entryDateComponents.month,
                  let entryYear = entryDateComponents.year,
                  let selectedDay = selectedDateComponents.day,
                  let selectedMonth = selectedDateComponents.month,
                  let selectedYear = selectedDateComponents.year else {
                return false
            }
            return entryDay == selectedDay
                && entryMonth == selectedMonth
                && entryYear == selectedYear
        }
        scrollTarget = firstEntry
    }
}

struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView(viewModel: TimelineViewModel(storageProvider: .previewProvider))
    }
}
