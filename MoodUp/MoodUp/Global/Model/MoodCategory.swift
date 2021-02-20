//
//  MoodCategory.swift
//  MoodUp
//
//  Created by Nicolas Spinner on 19.02.21.
//

import Foundation

struct MoodCategory : Codable {
    
	var identifier: Int
    var title: String
    var iconName: String
	
}

extension MoodCategory : Identifiable {
	var id: Int {
		identifier
	}		
}

extension MoodCategory : Equatable {
   
}

