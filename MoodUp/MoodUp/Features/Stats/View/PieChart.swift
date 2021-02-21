//
//  PieChart.swift
//  MoodUp
//
//  Created by Manuel Kunz on 20.02.21.
//

import Foundation
import SwiftUI

struct PieChart : View {
	
	var angles: [TmpAngle] = []
	
	init(values: [MoodTypeValue]) {
		angles = startEndAngles(from: values)
	}
	
	@ViewBuilder
	var body: some View {
		GeometryReader { geometry in
			ZStack(alignment: .center) {
				ForEach(angles, id: \.self) { angle in
					let widthHalf = (geometry.size.width / 2)
					let heightHalf = (geometry.size.height / 2)
					Path { path in
						path.move(to: CGPoint(x: widthHalf, y: heightHalf))
						path.addArc(center: .init(x: widthHalf, y: heightHalf), radius: min(widthHalf, heightHalf), startAngle: angle.start, endAngle: angle.range, clockwise: false)
					}
					.fill(angle.color)
				}
			}
			.aspectRatio(1, contentMode: .fill)
		}
	}

	private func startEndAngles(from values: [MoodTypeValue]) -> [TmpAngle] {
				
		let sum = values.reduce(0) { $0 + $1.value }

		var tuples: [TmpAngle] = []
		var currentStartAngle = 0.0
		values.forEach { value in
			let endAngle = ((360.0/sum) * value.value) + currentStartAngle
			tuples.append(TmpAngle(start: Angle(degrees: currentStartAngle), range: Angle(degrees: endAngle),color: value.type.color))
			currentStartAngle = endAngle
		}

		return tuples
	}
	
	
}

struct MoodTypeValue {
	var type: MoodType
	var value: Double
}

struct TmpAngle : Hashable {
	var start: Angle
	var range: Angle
	var color: Color
	func hash(into hasher: inout Hasher) {
		hasher.combine(start)
		hasher.combine(range)
	}
}

struct PieChart_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			PieChart(values: [
				MoodTypeValue(type: .bad, value: 1),
				MoodTypeValue(type: .awful, value: 1)
			])
		
			PieChart(values: [
				MoodTypeValue(type: .bad, value: 10),
				MoodTypeValue(type: .awful, value: 5),
				MoodTypeValue(type: .excellent, value: 25),
				MoodTypeValue(type: .great, value: 25),
				MoodTypeValue(type: .meh, value: 80)
			])
		}
	}
}
