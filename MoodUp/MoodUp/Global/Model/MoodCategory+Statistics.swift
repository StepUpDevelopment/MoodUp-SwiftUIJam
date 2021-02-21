//
//  MoodCategory+Statistics.swift
//  MoodUp
//
//  Created by Nicolas Spinner on 21.02.21.
//

import Foundation

extension MoodCategory {
    
    var statistic: CategoryStatistic? {
        let results = Dictionary(grouping: moodEntries ?? [], by: { (element: MoodEntry) in
            return element.moodType
        })
        var moodTypes: [MoodTypeValue] = []
        results.keys.forEach { key in
            moodTypes.append(MoodTypeValue(type: key, value: Double(results[key]!.count)))
        }
        guard !moodTypes.isEmpty else {
            return nil
        }
        return CategoryStatistic(moodCategory: self, moodTypeValues: moodTypes)
    }
    
}
