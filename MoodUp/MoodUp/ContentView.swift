//
//  ContentView.swift
//  MoodUp
//
//  Created by Nicolas Spinner on 19.02.21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
		ZStack {
			LinearGradient.main
				.ignoresSafeArea()
			Text("Hello, world!")
				.padding()
		}
			
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
