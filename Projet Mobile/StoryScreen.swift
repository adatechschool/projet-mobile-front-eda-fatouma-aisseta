//
//  StoryScreen.swift
//  Projet Mobile
//
//  Created by Macbook Fatouma on 15/01/2024.
//

import SwiftUI

struct StoryScreen: View {
    var message: Message?
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        VStack {
            if let message = message {
                Text("Ton histoire")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
                
                Text(message.content)
                    .foregroundColor(.white)
            } else {
                Text("No response yet.")
                    .foregroundColor(.white)
            }
        }
        .padding(20)
        .background(Color.black)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 2)
                .navigationTitle(Text("Personnalise ton histoire"))
                .navigationBarBackButtonHidden(true) // Cacher le bouton de retour par défaut

                                    // Ajouter un bouton personnalisé de retour en arrière
                                    .navigationBarItems(leading: Button(action: {
                                        self.presentationMode.wrappedValue.dismiss()
                                    }) {
                                        Image(systemName: "arrow.left.circle.fill")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                    })
        )
    }
}

struct StoryScreen_Previews: PreviewProvider {
    static var previews: some View {
       StoryScreen()
    }
}
