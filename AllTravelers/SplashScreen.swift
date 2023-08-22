//
//  SplashScreen.swift
//  AllTravelers
//
//  Created by Michael Martyn on 8/17/23.
//

import SwiftUI

struct SplashScreen: View {
    @State private var opacity: Double = 0.0
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image(systemName: "globe")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding(50)
                    .opacity(opacity)
                
                Text("The Travelers Allergy App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                    .opacity(opacity)
            }
        }
        .onAppear {
            withAnimation(Animation.easeIn(duration: 2.0)) {
                opacity = 1.0
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
