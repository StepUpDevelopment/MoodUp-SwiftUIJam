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
        Button(buttonTitle, action: buttonAction).buttonStyle(MainButtonStyle())
    }
}

struct MainButtonStyle: ButtonStyle {

  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
        .font(.headline)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .contentShape(Rectangle())
        .foregroundColor(configuration.isPressed ? Color.white.opacity(1.0) : Color.red)
        .listRowBackground(configuration.isPressed ? Color.blue.opacity(1.0) : Color.black)
  }
}
