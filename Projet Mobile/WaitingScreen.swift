//
//  WaitingScreen.swift
//  Projet Mobile
//
//  Created by Macbook Fatouma on 15/01/2024.
//
/*
import SwiftUI

struct WaitingScreen: View {
    @State private var showStoryScreen = false

    var body: some View {
        ZStack {
            Image("main")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.8)
            
            
            
            VStack {
                Spacer()
                ProgressView("Votre histoire se charge")
                    .foregroundColor(.black)
                    .padding()
                Spacer()
            }
        }
        
        //Ajout de 5 secondes de délai avant d'ouvrir la vue StoryScreen
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                self.showStoryScreen = true
            }
        }
        .sheet(isPresented: $showStoryScreen) {
            StoryScreen(story: .constant("Ceci est une histoire générée"))
        }
    }
}

struct WaitingScreen_Previews: PreviewProvider {
    static var previews: some View {
        WaitingScreen()
    }
}
*/
