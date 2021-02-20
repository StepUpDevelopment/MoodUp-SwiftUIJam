//
//  Date+Formatting.swift
//  MoodUp
//
//  Created by Nicolas Spinner on 20.02.21.
//

import Foundation

extension Date {
    
    func mediumString(locale: Locale = .current) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: self)
    }
    
    func monthAndYearString(locale: Locale = .current) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMyyyy")
        return dateFormatter.string(from: self)
    }
    
    func relativeOrMediumString(locale: Locale = .current, currentDate: Date = Date()) -> String {
        let secondsPerDay = 3600 * 24
        
        let difference = self.distance(to: currentDate)
        if Int(difference) / secondsPerDay > 3 {
            return mediumString(locale: locale)
        } else {
            let dateFormatter = RelativeDateTimeFormatter()
            dateFormatter.locale = locale
            dateFormatter.unitsStyle = .short
            dateFormatter.dateTimeStyle = .named
            
            return dateFormatter.localizedString(for: self, relativeTo: currentDate).capitalized
        }
    }
    
    func timeString(locale: Locale = .current) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: self)
    }
    
}
