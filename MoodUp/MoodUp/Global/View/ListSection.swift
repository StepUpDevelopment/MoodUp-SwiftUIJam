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
