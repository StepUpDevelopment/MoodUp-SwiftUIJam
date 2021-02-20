//
//  LinearGradient+Assets.swift
//  MoodUp
//
//  Created by Manuel Kunz on 19.02.21.
//

import Foundation
import SwiftUI

extension LinearGradient {
	
	static let main = LinearGradient(gradient: Gradient(colors: [.mainGradientTop, .mainGradientBottom]),
									 startPoint: .top,
									 endPoint: .bottom)
}
