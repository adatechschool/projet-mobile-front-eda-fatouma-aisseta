//
//  WaitingScreen.swift
//  Projet Mobile
//
//  Created by Macbook Fatouma on 15/01/2024.
//

import SwiftUI

struct WaitingScreen: View {
    var body: some View {
        ZStack {
            
            Image("main")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.8)
            
            VStack {
                ProgressView("Votre histoire se charge")
                    .foregroundColor(.black)
            }
        }
    }
}

struct WaitingScreen_Previews: PreviewProvider {
    static var previews: some View {
        WaitingScreen()
    }
}
