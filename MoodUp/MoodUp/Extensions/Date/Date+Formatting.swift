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
	
	func fullName(locale: Locale = .current) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.locale = locale
		dateFormatter.setLocalizedDateFormatFromTemplate("ddMMMMyyyy")
		let dayMontYear = dateFormatter.string(from: self)
		return "\(nameOfDay(locale: locale)), \(dayMontYear)"
	}
	
	func nameOfDay(locale: Locale = .current) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "EEEE"
		return dateFormatter.string(from: self)
	}
    
    func mediumAndTimeString(locale: Locale = .current) -> String {
        let medium = mediumString(locale: locale)
        let time = timeString(locale: locale)
        return "\(medium), \(time)"
    }
    
    func relativeOrMediumString(locale: Locale = .current, currentDate: Date = Date()) -> String {
        let secondsPerDay = 3600 * 24
        
        let difference = self.distance(to: currentDate)
        if Int(difference) / secondsPerDay != 0 {
            return timeString(locale: locale)
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
