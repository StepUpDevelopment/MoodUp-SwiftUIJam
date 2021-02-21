//
//  SettingsView.swift
//  MoodUp
//
//  Created by Fabian Köbel on 19.02.21.
//

import SwiftUI

struct SettingsView: View {
	init(){
		UITableView.appearance().backgroundColor = .clear
	}
	
    var body: some View {
		NavigationView {
			ZStack {
				LinearGradient.main
					.ignoresSafeArea()
				Form {
					Section(header: Text("Icons")) {
						Text("Icons von Icons8 (https://icons8.de)")
					}
				}
			}
			.navigationTitle("settings")
		}
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
