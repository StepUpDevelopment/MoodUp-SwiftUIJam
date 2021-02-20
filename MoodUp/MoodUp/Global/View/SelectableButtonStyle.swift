//
//  SelectableButtonStyle.swift
//  MoodUp
//
//  Created by Nicolas Spinner on 20.02.21.
//

import Foundation
import SwiftUI

struct SelectableButtonStyle: ButtonStyle {
    var isSelected: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(.primaryForegroundColor)
            .font(.subheadline)
            .padding()
            .background(Color.selectableButtonBackground)
            .cornerRadius(8)
            .frame(width: 100, height: 120)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.primaryForegroundColor, lineWidth: isHighlighted(configuration: configuration) ? 2 : 0)
            )
            .shadow(color: .primaryShadow,
                    radius: 4,
                    x: 0.0,
                    y: 4)
            .padding(4)
    }
    
    private func isHighlighted(configuration: Configuration) -> Bool {
        isSelected || configuration.isPressed
    }
}
