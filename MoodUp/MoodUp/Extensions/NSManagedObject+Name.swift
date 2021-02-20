//
//  NSManagedObject+Name.swift
//  MoodUp
//
//  Created by Manuel Kunz on 20.02.21.
//

import Foundation
import CoreData

extension NSManagedObject {
	static var className: String {
		return String(describing: self)
	}
}
