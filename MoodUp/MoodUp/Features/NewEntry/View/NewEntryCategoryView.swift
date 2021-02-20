//
//  NewEntryCategoryView.swift
//  MoodUp
//
//  Created by Fabian Köbel on 20.02.21.
//

import SwiftUI

struct NewEntryCategoryView: View {
    var body: some View {
        ZStack {
            LinearGradient.main
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("new_entry_category_title")
                    .font(.title)
                    .padding()
                Spacer()
                MainButton(buttonTitle: "save_mood") {
                    print("Save Mood")
                }
                .padding()
            }
        }
    }
}

struct NewEntryCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        NewEntryCategoryView()
    }
}
