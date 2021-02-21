//
//  MoodUpMoodChooserWidget.swift
//  MoodUpMoodChooserWidget
//
//  Created by Fabian Köbel on 21.02.21.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> MoodEntry {
        MoodEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (MoodEntry) -> ()) {
        let entry = MoodEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [MoodEntry] = []
        let entry = MoodEntry(date: Date())
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct MoodEntry: TimelineEntry {
    let date: Date
}

struct MoodUpMoodChooserWidgetEntryView : View {
    @Environment(\.widgetFamily) var size
    var entry: Provider.Entry

    var body: some View {
        switch size {
            case .systemLarge:
                ZStack {
                    Color.mainGradientTop
                        .ignoresSafeArea()
                    
                    VStack {
                        Spacer()
                        
                        Text("How are you feeling?")
                            .foregroundColor(.primaryForegroundColor)
                            .font(.title)
                        
                        Spacer()
                        
                        HStack {
                            MoodSelectionSmileyView(moodType: .awful)
                            MoodSelectionSmileyView(moodType: .bad)
                        }
                        
                        Spacer()
                        
                        HStack {
                            MoodSelectionSmileyView(moodType: .meh)
                            MoodSelectionSmileyView(moodType: .okay)
                            MoodSelectionSmileyView(moodType: .good)
                        }
                        
                        Spacer()
                        
                        HStack {
                            MoodSelectionSmileyView(moodType: .great)
                            MoodSelectionSmileyView(moodType: .excellent)
                        }
                        
                        Spacer()
                    }
                }
                .widgetURL(URL(string: "moodupwidget://shouldChooseMood"))
            @unknown default:
                Text("Widget not available")
        }
    }
}

struct MoodSelectionSmileyView : View {
    var moodType: MoodType
    
    var body: some View {
        Link(destination: URL(string: "moodupwidget://didChooseMood/\(moodType.rawValue)")!) {
            SmileyView(moodType: moodType)
                .frame(width: 100, height: 80)
        }
    }
}

@main
struct MoodUpMoodChooserWidget: Widget {
    let kind: String = "MoodUpMoodChooserWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MoodUpMoodChooserWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemLarge])
        .configurationDisplayName("Mood Chooser")
        .description("Select your current mood.")
    }
}

struct MoodUpMoodChooserWidget_Previews: PreviewProvider {
    static var previews: some View {
        MoodUpMoodChooserWidgetEntryView(entry: MoodEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
