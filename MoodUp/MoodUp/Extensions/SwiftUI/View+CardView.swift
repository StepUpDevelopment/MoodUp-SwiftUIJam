//
//  View+CardView.swift
//  MoodUp
//
//  Created by Nicolas Spinner on 20.02.21.
//

import SwiftUI

extension View {
    
    func embedInCardView() -> some View {
        self
            .cornerRadius(10)
            .shadow(radius: 5)
    }
    
}
