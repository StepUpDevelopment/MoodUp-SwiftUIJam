//
//  TimelineView.swift
//  MoodUp
//
//  Created by Nicolas Spinner on 19.02.21.
//

import SwiftUI

struct TimelineView: View {
    var body: some View {
		ZStack {
			LinearGradient.main
				.ignoresSafeArea()
            VStack {
                Text("Hello, world!")
                    .padding()

                MainButton(buttonTitle: "add_mood", buttonAction: { print("test")})
            }
		}
			
    }
}

struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView()
    }
}
