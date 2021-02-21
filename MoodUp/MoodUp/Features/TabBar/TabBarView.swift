//
//  TabBarView.swift
//  MoodUp
//
//  Created by Nicolas Spinner on 19.02.21.
//

import SwiftUI

struct TabBarView: View {

    @State private var selectedTab = Tab.timeline
	var storageProvider: StorageProvider

    enum Tab: Int {
        case timeline, stats, settings
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            TimelineView(viewModel: TimelineViewModel(storageProvider: storageProvider))
                .tabItem {
                    TabItem(title: "timeline", systemImage: "house.fill")
                }
                .tag(Tab.timeline)
            StatsView(viewModel: StatsViewModel(storageProvider: storageProvider))
                .tabItem {
                    TabItem(title: "stats", systemImage: "speedometer")
                }
                .tag(Tab.stats)
            SettingsView()
                .tabItem {
                    TabItem(title: "settings", systemImage: "gear")
                }
                .tag(Tab.settings)
        }
        .onOpenURL { url in
            guard let tabIdentifier = url.tabIdentifier else {
                return
            }

            selectedTab = tabIdentifier
        }
        .edgesIgnoringSafeArea(.top)
        .accentColor(.tabbarAccent)
    }
}

struct TabItem: View {
    var title: LocalizedStringKey
    var systemImage: String

    var body: some View {
        VStack {
            Image(systemName: systemImage)
                .imageScale(.large)
            Text(title)
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(storageProvider: StorageProvider(inMemory: true))
    }
}
