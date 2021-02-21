//
//  MoodType.swift
//  MoodUp
//
//  Created by Nicolas Spinner on 19.02.21.
//

import Foundation
import SwiftUI

enum MoodType: Int, Codable, CaseIterable {
    case awful = 0
    case bad = 1
    case meh = 2
    case okay = 3
    case good = 4
    case great = 5
    case excellent = 6
}

extension MoodType {
	
	var icon: Image {		
		return Image("\(self)")
	}
	
	var color: Color {
		switch self {
		case .awful:
			return .awfulMood
		case .bad:
			return .badMood
		case .meh:
			return .mehMood
		case .okay:
			return .okayMood
		case .good:
			return .goodMood
		case .great:
			return .greatMood
		case .excellent:
			return .excellentMood
		}
	}
    
    var titleKey: String {
        switch self {
        case .awful:
            return "awful"
        case .bad:
            return "bad"
        case .meh:
            return "meh"
        case .okay:
            return "okay"
        case .good:
            return "good"
        case .great:
            return "great"
        case .excellent:
            return "excellent"
        }
    }
}
