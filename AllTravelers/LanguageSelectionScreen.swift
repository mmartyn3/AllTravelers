//
//  LanguageSelectionScreen.swift
//  AllTravelers
//
//  Created by Michael Martyn on 8/17/23.
//

import SwiftUI

struct LanguageSelectionScreen: View {
    @Binding var selectedLanguage: String
    let languages = ["English", "Spanish", "French", "German", "Italian"]
    
    var body: some View {
        List(languages, id: \.self) { language in
            Button(action: {
                self.selectedLanguage = language
            }) {
                Text(language)
                    .foregroundColor(self.selectedLanguage == language ? .blue : .black)
            }
        }
        .navigationBarTitle("Select Language", displayMode: .inline)
    }
}
