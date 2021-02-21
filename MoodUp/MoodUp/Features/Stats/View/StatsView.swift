//
//  StatsView.swift
//  MoodUp
//
//  Created by Fabian Köbel on 19.02.21.
//

import SwiftUI

struct StatsView: View {
	
	@ObservedObject var viewModel: StatsViewModel
	
	var columns: [GridItem] = [
			GridItem(.flexible(minimum: 40), spacing: 16),
			GridItem(.flexible(minimum: 40), spacing: 16),
		]
	
    var body: some View {
		NavigationView {
			ZStack {
				LinearGradient.main
					.ignoresSafeArea()
				ScrollView {
					LazyVGrid(
						columns: columns,
						alignment: .center,
						spacing: 16
					) {
						ForEach(viewModel.categoryStatistics, id: \.id) { statistic in
                            NavigationLink(
                                destination: CategoryStatsView(category: statistic.moodCategory),
                                label: {
                                    CategoryStatsGridItemView(statistic: statistic)
                                })
						}
					}
					.padding([.all])
				}
				.navigationTitle("stats")
			}
		}
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
		StatsView(viewModel: StatsViewModel(storageProvider: StorageProvider(inMemory: true)))
    }
}
