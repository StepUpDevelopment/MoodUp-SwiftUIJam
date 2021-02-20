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
        Button(buttonTitle, action: buttonAction)
            .buttonStyle(MainButtonStyle())
            .cornerRadius(24.0)
    }
}

struct MainButtonStyle: ButtonStyle {

  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
        .font(.headline)
        .padding([.leading, .trailing], 48.0)
        .padding([.top, .bottom], 16.0)
        .foregroundColor(configuration.isPressed ? Color.white.opacity(0.5) : Color.white)
        .background(Color.primaryForegroundColor)
  }}
