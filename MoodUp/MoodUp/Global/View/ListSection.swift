//
//  ListSection.swift
//  MoodUp
//
//  Created by Manuel Kunz on 20.02.21.
//

import Foundation

struct ListSection<T> : Identifiable where T: Identifiable {
	
	var id: UUID = UUID()
	var title: String
	var items: [T]
	
}

extension ListSection : Hashable, Equatable  {
	
	static func == (lhs: ListSection<T>, rhs: ListSection<T>) -> Bool {
		lhs.id == rhs.id
	}
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
	
}
