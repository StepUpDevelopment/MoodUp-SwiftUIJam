//
//  View+CardView.swift
//  MoodUp
//
//  Created by Nicolas Spinner on 20.02.21.
//

import SwiftUI

extension View {
    
    func embedInCardView() -> some View {
        CardView(content: self)
    }
    
}

struct CardView<Content>: View where Content: View {
    @Environment(\.colorScheme) var colorScheme
    var content: Content
    
    var body: some View {
        content
            .cornerRadius(8)
            .shadow(color: .primaryShadow,
                    radius: colorScheme == .light ? 4 : 0,
                    x: 0.0,
                    y: colorScheme == .light ? 4 : 0)
    }
    
}
