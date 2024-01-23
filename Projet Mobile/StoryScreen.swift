//
//  StoryScreen.swift
//  Projet Mobile
//
//  Created by Macbook Fatouma on 15/01/2024.
//

import SwiftUI

struct StoryScreen: View {
    @Binding var story: String
    @Environment(\.presentationMode) var presentationMode
    @State private var isCategorieViewPresented = false
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Text(story)
                    .foregroundColor(.black)
                
                
                // Bouton nouvelle histoire qui renvoie vers CategorieView
                
                    .navigationBarItems(trailing:
                                            Button(action: {
                        self.isCategorieViewPresented.toggle()
                    }) {
                        Text("Nouvelle histoire")
                    }
                    )
            }
            .sheet(isPresented: $isCategorieViewPresented) {
                CategorieView()
            }
        }
    }
    
    struct StoryScreen_Previews: PreviewProvider {
        static var previews: some View {
            StoryScreen(story: .constant("Ceci est une histoire générée"))
        }
    }
}
