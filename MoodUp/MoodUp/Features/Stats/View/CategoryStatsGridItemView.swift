//
//  CategoryStatsGridItemView.swift
//  MoodUp
//
//  Created by Manuel Kunz on 21.02.21.
//

import Foundation
import SwiftUI

struct CategoryStatsGridItemView: View {
	
	var statistic: CategoryStatistic
	
	var body: some View {
		VStack {
			ZStack(alignment: .center) {
				PieChart(values: statistic.moodTypeValues)
				Image(statistic.moodCategory.iconName)
					.resizable()
					.frame(width: 64.0, height: 64.0)
			}
			Text(LocalizedStringKey(statistic.moodCategory.title))				
		}
		.clipped()
		.aspectRatio(1, contentMode: .fit)
		.padding()
		.background(Color.secondaryBackground)
		.embedInCardView()
	}
	
}

struct CategoryStatsGridItemView_Previews: PreviewProvider {
	static var previews: some View {
		CategoryStatsGridItemView(statistic:
			CategoryStatistic(moodCategory:
				MoodCategory(identifier: 2,
							 title: "Food",
							 iconName: "CategoryFood"),
							  moodTypeValues: [
									MoodTypeValue(type: .bad, value: 10),
									MoodTypeValue(type: .awful, value: 5),
									MoodTypeValue(type: .excellent, value: 25),
									MoodTypeValue(type: .great, value: 25),
									MoodTypeValue(type: .meh, value: 80)
							  ]
			)
		)
	}
}
