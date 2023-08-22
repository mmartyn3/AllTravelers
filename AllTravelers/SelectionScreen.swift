//
//  SelectionScreen.swift
//  AllTravelers
//
//  Created by Michael Martyn on 8/17/23.
//

import SwiftUI

struct SelectionScreen: View {
    @Binding var selectedIngredients: [String]
    
    let ingredients = ["coconut", "peanuts", "tree nuts", "milk", "eggs", "wheat", "soy", "fish", "shellfish", "sesame"]
    
    var body: some View {
        List(ingredients, id: \.self) { ingredient in
            Button(action: {
                self.toggleSelection(of: ingredient)
            }) {
                HStack {
                    Text(ingredient)
                    if selectedIngredients.contains(ingredient) {
                        Spacer()
                        Image(systemName: "checkmark")
                    }
                }
            }
        }
        .navigationTitle("Select Ingredients")
    }
    
    func toggleSelection(of ingredient: String) {
        if let index = selectedIngredients.firstIndex(of: ingredient) {
            selectedIngredients.remove(at: index)
        } else {
            selectedIngredients.append(ingredient)
        }
    }
}

struct SelectionScreen_Previews: PreviewProvider {
    static var previews: some View {
        SelectionScreen(selectedIngredients: .constant(["Coconut"]))
    }
}

