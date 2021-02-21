//
//  CategoryStatsDetailView.swift
//  MoodUp
//
//  Created by Nicolas Spinner on 21.02.21.
//

import SwiftUI

struct CategoryStatsView: View {
    
    var category: MoodCategory
    
    var body: some View {
        ZStack(alignment: .center) {
            PieChart(values: statistic.moodTypeValues)
            Image(statistic.moodCategory.iconName)
                .resizable()
                .frame(width: 64.0, height: 64.0)
        }
    }
}

struct CategoryStatsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryStatsView()
    }
}
