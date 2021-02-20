//
//  MainButton.swift
//  MoodUp
//
//  Created by Fabian Köbel on 19.02.21.
//

import SwiftUI

struct MainButton: View {
    var buttonTitle: LocalizedStringKey
	var enabled = true
    var buttonAction: () -> Void
    
    var body: some View {
        Button(action: {
            buttonAction()
        }, label: {
            Text(buttonTitle)
		})
        .buttonStyle(MainButtonStyle(enabled: enabled))
        .cornerRadius(24.0)
    }
}

struct MainButtonStyle: ButtonStyle {
	
	var enabled = true
	
    func makeBody(configuration: Self.Configuration) -> some View {
		configuration.label
			.font(.headline)
			.padding([.leading, .trailing], 48.0)
			.padding([.top, .bottom], 16.0)
			.foregroundColor(configuration.isPressed ? Color.white.opacity(0.5) : Color.white)
			.background(enabled ? Color.primaryForegroundColor : Color.primaryForegroundColorInactive)
			
		}
}

struct MainButton_Previews: PreviewProvider {
	static var previews: some View {
		VStack {
			MainButton(buttonTitle: "Enabled") {}
			MainButton(buttonTitle: "Disabled", enabled: false) {}
		}
	}
}
