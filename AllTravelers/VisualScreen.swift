//
//  VisualScreen.swift
//  AllTravelers
//
//  Created by Michael Martyn on 8/17/23.
//

import SwiftUI

struct VisualScreen: View {
    @Binding var selectedIngredients: [String]
    @State private var selectedLanguage: String = "Spanish (Spain)"
    @State private var searchText: String = ""

    
    init(selectedIngredients: Binding<[String]>) {
            self._selectedIngredients = selectedIngredients
            
            // Load selected language from UserDefaults
            let savedLanguage = UserDefaults.standard.string(forKey: "SelectedLanguage") ?? "Spanish (Spain)"
            self._selectedLanguage = State(initialValue: savedLanguage)
            
            // Load selected ingredients from UserDefaults
            if let savedIngredients = UserDefaults.standard.data(forKey: "SelectedIngredients"),
               let decodedIngredients = try? JSONDecoder().decode([String].self, from: savedIngredients) {
                self._selectedIngredients = Binding.constant(decodedIngredients)
            }
        }
    
    let languages = [
        ("Afrikaans (South Africa)", "🇿🇦"),
        ("Albanian (Albania)", "🇦🇱"),
        ("Amharic (Ethiopia)", "🇪🇹"),
        ("Arabic (Egypt)", "🇸🇦"),
        ("Armenian (Armenia)", "🇦🇲"),
        ("Azerbaijani (Azerbaijan)", "🇦🇿"),
        ("Basque (Spain)", "🇪🇸"),
        ("Belarusian (Belarus)", "🇧🇾"),
        ("Bengali (Bangladesh)", "🇧🇩"),
        ("Bosnian (Bosnia and Herzegovina)", "🇧🇦"),
        ("Bulgarian (Bulgaria)", "🇧🇬"),
        ("Catalan (Spain)", "🇪🇸"),
        ("Cebuano (Philippines)", "🇵🇭"),
        ("Chinese (Simplified) (China)", "🇨🇳"),
        ("Chinese (Traditional) (Taiwan)", "🇹🇼"),
        ("Corsican (France)", "🇫🇷"),
        ("Croatian (Croatia)", "🇭🇷"),
        ("Czech (Czech Republic)", "🇨🇿"),
        ("Danish (Denmark)", "🇩🇰"),
        ("Dutch (Netherlands)", "🇳🇱"),
        ("Esperanto (International)", "🌍"),
        ("Estonian (Estonia)", "🇪🇪"),
        ("Finnish (Finland)", "🇫🇮"),
        ("French (France)", "🇫🇷"),
        ("Frisian (Netherlands)", "🇳🇱"),
        ("Galician (Spain)", "🇪🇸"),
        ("Georgian (Georgia)", "🇬🇪"),
        ("German (Germany)", "🇩🇪"),
        ("Greek (Greece)", "🇬🇷"),
        ("Gujarati (India)", "🇮🇳"),
        ("Haitian Creole (Haiti)", "🇭🇹"),
        ("Hausa (Nigeria)", "🇳🇬"),
        ("Hawaiian (USA)", "🇺🇸"),
        ("Hebrew (Israel)", "🇮🇱"),
        ("Hindi (India)", "🇮🇳"),
        ("Hmong (China)", "🇨🇳"),
        ("Hungarian (Hungary)", "🇭🇺"),
        ("Icelandic (Iceland)", "🇮🇸"),
        ("Igbo (Nigeria)", "🇳🇬"),
        ("Indonesian (Indonesia)", "🇮🇩"),
        ("Irish (Ireland)", "🇮🇪"),
        ("Italian (Italy)", "🇮🇹"),
        ("Japanese (Japan)", "🇯🇵"),
        ("Javanese (Indonesia)", "🇮🇩"),
        ("Kannada (India)", "🇮🇳"),
        ("Kazakh (Kazakhstan)", "🇰🇿"),
        ("Khmer (Cambodia)", "🇰🇭"),
        ("Korean (South Korea)", "🇰🇷"),
        ("Kurdish (Iraq)", "🇮🇶"),
        ("Kyrgyz (Kyrgyzstan)", "🇰🇬"),
        ("Lao (Laos)", "🇱🇦"),
        ("Latvian (Latvia)", "🇱🇻"),
        ("Lithuanian (Lithuania)", "🇱🇹"),
        ("Luxembourgish (Luxembourg)", "🇱🇺"),
        ("Macedonian (North Macedonia)", "🇲🇰"),
        ("Malagasy (Madagascar)", "🇲🇬"),
        ("Malay (Malaysia)", "🇲🇾"),
        ("Malayalam (India)", "🇮🇳"),
        ("Maltese (Malta)", "🇲🇹"),
        ("Maori (New Zealand)", "🇳🇿"),
        ("Marathi (India)", "🇮🇳"),
        ("Mongolian (Mongolia)", "🇲🇳"),
        ("Burmese (Myanmar)", "🇲🇲"),
        ("Nepali (Nepal)", "🇳🇵"),
        ("Norwegian (Norway)", "🇳🇴"),
        ("Nyanja (Chichewa) (Malawi)", "🇲🇼"),
        ("Pashto (Pakistan)", "🇵🇰"),
        ("Persian (Iran)", "🇮🇷"),
        ("Polish (Poland)", "🇵🇱"),
        ("Portuguese (Portugal)", "🇵🇹"),
        ("Punjabi (India)", "🇮🇳"),
        ("Romanian (Romania)", "🇷🇴"),
        ("Russian (Russia)", "🇷🇺"),
        ("Samoan (Samoa)", "🇼🇸"),
        ("Serbian (Serbia)", "🇷🇸"),
        ("Sesotho (Lesotho)", "🇱🇸"),
        ("Shona (Zimbabwe)", "🇿🇼"),
        ("Sindhi (Pakistan)", "🇵🇰"),
        ("Sinhalese (Sri Lanka)", "🇱🇰"),
        ("Slovak (Slovakia)", "🇸🇰"),
        ("Slovenian (Slovenia)", "🇸🇮"),
        ("Somali (Somalia)", "🇸🇴"),
        ("Spanish (Spain)", "🇪🇸"),
        ("Sundanese (Indonesia)", "🇮🇩"),
        ("Swahili (Tanzania)", "🇹🇿"),
        ("Swedish (Sweden)", "🇸🇪"),
        ("Tagalog (Philippines)", "🇵🇭"),
        ("Tajik (Tajikistan)", "🇹🇯"),
        ("Tamil (India)", "🇮🇳"),
        ("Telugu (India)", "🇮🇳"),
        ("Thai (Thailand)", "🇹🇭"),
        ("Turkish (Turkey)", "🇹🇷"),
        ("Ukrainian (Ukraine)", "🇺🇦"),
        ("Urdu (Pakistan)", "🇵🇰"),
        ("Uyghur (China)", "🇨🇳"),
        ("Uzbek (Uzbekistan)", "🇺🇿"),
        ("Vietnamese (Vietnam)", "🇻🇳"),
        ("Welsh (Wales)", "🏴󠁧󠁢󠁷󠁬󠁳󠁿"),
        ("Xhosa (South Africa)", "🇿🇦"),
        ("Yiddish (Israel)", "🇮🇱"),
        ("Zulu (South Africa)", "🇿🇦")
    ]
    
    var body: some View {
        let filteredLanguages: [(String, String)] = languages.filter { fullLanguageName, _ in
            // Split the full language name into its components
            let components = fullLanguageName.components(separatedBy: " (")
            let languageName = components.first ?? ""
            let countryName = components.last?.replacingOccurrences(of: ")", with: "") ?? ""

            // Check if either component contains the search text
            return searchText.isEmpty ||
                   languageName.lowercased().contains(searchText.lowercased()) ||
                   countryName.lowercased().contains(searchText.lowercased())
        }

        
        VStack {
                // Icons and Language Selector at the Top of the Page
                HStack {
                    Image(systemName: "cross.case")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.red)
                    
                    // Center-Aligned Language Dropdown with Flags
                    VStack {
                        // Search TextField
                        TextField("Search Language", text: $searchText)
                            .padding(10)
                            .background(Color.secondary.opacity(0.2))
                            .cornerRadius(10)
                            .padding(.horizontal)

                        // Conditionally display the list of languages when user starts typing
                        if !searchText.isEmpty {
                            List(filteredLanguages, id: \.0) { fullLanguageName, flag in
                                Button(action: {
                                    selectedLanguage = fullLanguageName
                                    searchText = ""
                                }) {
                                    Text("\(flag) \(fullLanguageName)")
                                }
                            }
                            .frame(maxHeight: 200) // Limit the height of the List
                            .listStyle(PlainListStyle()) // This will remove any default list styling
                        }
                        else {
                            // Display the currently selected language when not searching
                            HStack {
                                Text(languages.first(where: { $0.0 == selectedLanguage })?.1 ?? "") // Flag
                                Text(selectedLanguage) // Full language name
                            }
                            .padding()
                        }
                    }
                    
                    Image(systemName: "fork.knife.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.red)
                }
                .padding(.horizontal)
                
                Spacer().frame(height: 50)
                
                // Translated Phrase at the Bottom with English Below
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.red)
                    
                    Text(Translations.statement[selectedLanguage] ?? "")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.red)
                }
                .padding(.horizontal)
                
                Text("I am allergic to some ingredients. I can not eat food containing the following foods:")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                
                Spacer().frame(height: 50)
                
                // Card-style Layout for Translated Ingredients
                ScrollView {
                    ForEach(selectedIngredients, id: \.self) { ingredient in
                        VStack(alignment: .leading) {
                            HStack {
                                Text(Translations.ingredients[ingredient]?[selectedLanguage] ?? ingredient)
                                    .font(.title2)
                                    .fontWeight(.semibold) // Make translated ingredient name semibold
                                    .foregroundColor(.red) // Make translated ingredient name red
                                
                                Text("(\(ingredient))")
                                    .font(.title2)
                                    .fontWeight(.regular) // Make English ingredient name not semibold
                                    .foregroundColor(.gray) // Make English ingredient name grey
                            }
                        }
                        .padding()
                        .background(Color.secondary.opacity(0.1))
                        .cornerRadius(15)
                        .shadow(color: .gray.opacity(0.4), radius: 10, x: 0, y: 10)
                        .padding(.horizontal)
                        .padding(.bottom, 5)
                    }
                }
                
                Spacer().frame(height: 50) // This will ensure the translated text is equally spaced
                
            }
            .navigationBarTitle("Your Allergies", displayMode: .inline)
    }
    private func saveSelectedIngredientsToUserDefaults() {
            if let encoded = try? JSONEncoder().encode(selectedIngredients) {
                UserDefaults.standard.set(encoded, forKey: "SelectedIngredients")
            }
    }
}

struct CardView: View {
    var ingredient: String
    var translation: String
    
    var body: some View {
        HStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.yellow)
                .font(.system(size: 30))
            
            VStack(alignment: .leading) {
                Text(translation)
                    .font(.title2)
                Text(ingredient)
                    .font(.title3)
                    .foregroundColor(.gray)
            }
            
            Spacer()

        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(15)
        .padding(.horizontal)
    }
}

struct VisualScreen_Previews: PreviewProvider {
    static var previews: some View {
        VisualScreen(selectedIngredients: .constant(["Coconut", "Milk"]))
    }
}
