//
//  ContentView.swift
//  AllTravelers
//
//  Created by Michael Martyn on 8/17/23.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedIngredients: [String] = []
    @State private var selectedLanguage: String = "Spanish"
    @State private var isActive: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                if isActive {
                    TabView {
                        SelectionScreen(selectedIngredients: $selectedIngredients)
                            .tabItem {
                                Label("Ingredients", systemImage: "list.dash")
                            }
                        
                        VisualScreen(selectedIngredients: $selectedIngredients)
                            .tabItem {
                                Label("Allergies", systemImage: "exclamationmark.triangle.fill")
                            }
                    }
                } else {
                    SplashScreen()
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
