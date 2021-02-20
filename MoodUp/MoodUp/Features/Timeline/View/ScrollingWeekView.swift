//
//  ScrollingWeekView.swift
//  MoodUp
//
//  Created by Nicolas Spinner on 20.02.21.
//

import SwiftUI

struct ScrollingWeekView: View {
    
    var weekItems: [WeekItem] = {
        let date = Date()
        return WeekItem.weekItems(startingDate: date, offset: 3, numberOfItems: 30)
    }()
    
    @State var selectedItem: WeekItem = WeekItem.fromDate(date: Date())
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { value in
                    LazyHStack(spacing: 0) {
                        ForEach(weekItems, id: \.self) { weekItem in
                            Button(action: {
                                if weekItem.isSelectable {
                                    selectedItem = weekItem
                                    withAnimation {
                                        value.scrollTo(selectedItem, anchor: .center)
                                    }
                                }
                            }, label: {
                                VStack {
                                    Text(String(weekItem.day))
                                        .fontWeight(weekItem == self.selectedItem ? .bold : .regular)
                                    Text(weekItem.title)
                                        .fontWeight(weekItem == self.selectedItem ? .bold : .regular)
                                }
                                .font(weekItem == selectedItem ? .title3 : .body)
                                .foregroundColor(weekItem.isSelectable ? .black : .gray)
                                .frame(width: proxy.size.width / 7)
                            })
                            .disabled(!weekItem.isSelectable)
                        }
                    }
                    .onAppear {
                        value.scrollTo(weekItems[weekItems.endIndex - 1], anchor: .trailing)
                    }
                }
            }
        }
        .padding()
    }
    
}

struct WeekItem: Hashable {
    var day: Int
    var title: String
    var timestamp: TimeInterval
    var isSelectable: Bool
    
    static func fromDate(date: Date, isSelectable: Bool = true) -> WeekItem {
        let components = Calendar.current.dateComponents([.day], from: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayName = dateFormatter.string(from: date).prefix(3)
        return WeekItem(day: components.day ?? 0,
                        title: String(dayName),
                        timestamp: date.timeIntervalSince1970,
                        isSelectable: isSelectable)
    }
    
    static func weekItems(startingDate: Date, offset: Int = 0, numberOfItems: Int) -> [WeekItem] {
        let startIndex = offset - numberOfItems
        let endIndex = offset
        var totalDays: [WeekItem] = []
        for index in startIndex...endIndex {
            let day = Calendar.current.date(byAdding: .day, value: index, to: startingDate)!
            totalDays.append(.fromDate(date: day, isSelectable: index <= 0))
        }
        return totalDays
    }
    
    static func == (lhs: WeekItem, rhs: WeekItem) -> Bool { return lhs.title == rhs.title && lhs.day == rhs.day
    }
    
}

struct ScrollingWeekView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollingWeekView()
    }
}
