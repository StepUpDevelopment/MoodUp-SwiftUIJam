//
//  CategoryStatsView.swift
//  MoodUp
//
//  Created by Nicolas Spinner on 21.02.21.
//

import SwiftUI

struct CategoryStatsView: View {
    
    var category: MoodCategory?
    
    var body: some View {
        ZStack {
            LinearGradient.main
                .ignoresSafeArea()
        
            VStack {
                Text(LocalizedStringKey(category?.title ?? ""))
                    .foregroundColor(.primaryForegroundColor)
                    .font(.title)
                    .fontWeight(.bold)
                if let statistic = category?.statistic {
                    ZStack(alignment: .center) {
                        PieChart(values: statistic.moodTypeValues)
                            .aspectRatio(1, contentMode: .fit)
                        Image(statistic.moodCategory.iconName)
                            .resizable()
                            .frame(width: 64.0, height: 64.0)
                    }
                    .padding()
                    .background(Color.secondaryBackground)
                    .embedInCardView()
                    .padding()
                    
                    Spacer()
                } else {
                    Text("No stats found")
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct CategoryStatsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryStatsView(category: MoodCategory(identifier: 1, title: "category_family", iconName: "CategoryFamily"))
    }
}
