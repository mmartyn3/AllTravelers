//
//  OpeningFlowScreen.swift
//  AllTravelers
//
//  Created by Michael Martyn on 8/17/23.
//

import SwiftUI

struct OpeningFlowScreen: View {
    @State private var currentStep: Int = 0
    @State private var selectedIngredients: [String] = []
    @State private var selectedLanguage: String = "English"
    
    var body: some View {
        NavigationView {
            VStack {
                if currentStep == 0 {
                    SelectionScreen(selectedIngredients: $selectedIngredients)
                } else if currentStep == 1 {
                    LanguageSelectionScreen(selectedLanguage: $selectedLanguage)
                } else if currentStep == 2 {
                    VisualScreen(selectedIngredients: $selectedIngredients)
                }
                
                Button(action: {
                    withAnimation {
                        if currentStep < 2 {
                            self.currentStep += 1
                        } else {
                            self.currentStep = 0
                            self.selectedIngredients.removeAll()
                            self.selectedLanguage = "English"
                        }
                    }
                }) {
                    Text(currentStep < 2 ? "Next" : "Finish")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled((currentStep == 0 && selectedIngredients.isEmpty) || (currentStep == 1 && selectedLanguage.isEmpty))
            }
            .navigationBarTitle("Allergy App", displayMode: .inline)
        }
    }
}
