//
//  URL+Deeplinks.swift
//  MoodUp
//
//  Created by Fabian Köbel on 21.02.21.
//

import Foundation

extension URL {
  var isDeeplink: Bool {
    return scheme == "moodupwidget"
  }

    var tabIdentifier: TabBarView.Tab? {
        guard isDeeplink else { return nil }

        switch host {
            case "didChooseMood": return .timeline
            case "shouldChooseMood": return .timeline
            default: return nil
        }
    }
    
    var shouldShowAddMoodSheet: Bool {
        guard isDeeplink else { return false }

        return host == "shouldChooseMood"
    }
    
    var shouldHandleChoosenMood: Bool {
        guard isDeeplink else { return false }

        return host == "didChooseMood"
    }
    
    var selectedMoodType: MoodType {
        guard isDeeplink else { return MoodType.excellent }
        guard shouldHandleChoosenMood else { return MoodType.excellent }
        
        return MoodType(rawValue: Int(pathComponents[1])!)!
    }
}
