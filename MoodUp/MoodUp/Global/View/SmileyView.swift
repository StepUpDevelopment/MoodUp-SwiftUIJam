//
//  SmileyView.swift
//  MoodUp
//
//  Created by Manuel Kunz on 19.02.21.
//

import Foundation
import SwiftUI

struct SmileyView: View {
	
	var moodType: MoodType
	var color: Color?
	
	var body: some View {
		
		ZStack {
			Circle()
				.fill(color ?? moodType.color)
			moodType.icon.renderingMode(.template)
				.resizable()
				.aspectRatio(contentMode: .fit)
				.foregroundColor(.smileyForegroundColor)
		}
	}
}

struct SmileyView_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			SmileyView(moodType: .bad)
				.padding()
			
			VStack {
				HStack {
					SmileyView(moodType: .awful)
					SmileyView(moodType: .bad)
				}
				
				HStack {
					SmileyView(moodType: .meh)
					SmileyView(moodType: .okay)
					SmileyView(moodType: .good)
				}
				HStack {
					SmileyView(moodType: .great)
					SmileyView(moodType: .excellent)
				}
			}.padding()
			
		}
	}
}
