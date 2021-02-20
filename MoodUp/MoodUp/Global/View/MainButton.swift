//
//  MainButton.swift
//  MoodUp
//
//  Created by Fabian Köbel on 19.02.21.
//

import SwiftUI

struct MainButton: View {
    var buttonTitle: LocalizedStringKey
    var buttonAction: () -> Void
    
    var body: some View {
        Button(action: {
            buttonAction()
        }, label: {
            Text(buttonTitle)
		})
        .buttonStyle(MainButtonStyle())
        .cornerRadius(24.0)
    }
}

struct MainButtonStyle: ButtonStyle {

    func makeBody(configuration: Self.Configuration) -> some View {
		MainButtonContent(configuration: configuration)
    }
    
    private struct MainButtonContent: View {
        let configuration: ButtonStyle.Configuration
        @Environment(\.colorScheme) var colorScheme
        @Environment(\.isEnabled) var isEnabled
        var body: some View {
            configuration.label
                .font(.headline)
                .padding([.leading, .trailing], 48.0)
                .padding([.top, .bottom], 16.0)
                .foregroundColor(foreground())
                .background(isEnabled ? Color.primaryButtonForeground : Color.primaryForegroundColorInactive)
        }
        
        private func foreground() -> Color {
            if !isEnabled {
                return Color.gray
            } else {
                return configuration.isPressed ? Color.white.opacity(0.5) : Color.white
            }
        }
    }
}

struct MainButton_Previews: PreviewProvider {
	static var previews: some View {
		VStack {
			MainButton(buttonTitle: "Enabled") {}
			MainButton(buttonTitle: "Disabled") {}
		}
	}
}
