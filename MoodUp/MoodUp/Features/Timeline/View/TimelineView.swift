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
    
    @State private var scrollTarget: ListSection<MoodEntry>?

    var body: some View {
        NavigationView {
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
                                ForEach(viewModel.sections, id: \.self) { section in
                                    Text(section.title.uppercased())
                                        .fontWeight(.light)
                                        .padding(.top)
                                    ForEach(section.items, id: \.self) { moodEntry in
                                        NavigationLink(destination: MoodEntryDetailView(moodEntry: moodEntry)) {
                                            TimelineCell(moodEntry: moodEntry)
                                        }
                                    }
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
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        self.viewModel.preselectedMood = nil
                        self.isShowingNewEntryView = true
                    }).sheet(isPresented: $isShowingNewEntryView) {
                        NewEntryMoodView(selectedMood: self.viewModel.preselectedMood, isShowingNewEntryView: self.$isShowingNewEntryView, storageProvider: viewModel.storageProvider)
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
            .onOpenURL { url in
                if url.shouldHandleChoosenMood {
                    self.viewModel.preselectedMood = url.selectedMoodType
                }
                
                if url.shouldShowAddMoodSheet || url.shouldHandleChoosenMood {
                    self.isShowingNewEntryView = true
                }
            }
        }
    }

    private func handleDaySelected(dayItem: DayItem) {
        let selectedDate = Date(timeIntervalSince1970: dayItem.timestamp)
		//TODO: Passt die Anpassung so ? Funktionieren tut es zumindest mal
		let firstEntry = viewModel.sections.first { section in
            let calendar = Calendar.current
			let entryDateComponents = calendar.dateComponents([.day, .month, .year], from: section.items.first?.createdDate ?? Date())
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
