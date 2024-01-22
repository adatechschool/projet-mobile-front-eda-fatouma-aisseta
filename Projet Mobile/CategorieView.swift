//
//  CategorieView.swift
//  Projet Mobile
//
//  Created by Macbook Fatouma on 15/01/2024.
//

import SwiftUI

struct CategorieView: View {
    @State var username: String = ""
    @State var storyResume : String = ""
    @State private var storyLength: String = ""
    @Environment(\.presentationMode) var presentationMode
    //pour dissoudre ou fermer une vue modale ou une vue présentée à l'aide de la navigation. Ensuite, elle appelle la méthode dismiss() pour fermer ou dissoudre la vue.
    


    
    var body: some View {
        
        ZStack{
            LinearGradient(gradient: Gradient (colors: [ Color(.systemBlue)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea(.all, edges: .all)
            
            VStack{
                
                NavigationView{
                    
                    Form{
                        Section(header: Text("Longueur de l'histoire")) {
                            Picker("Choisissez la longueur", selection: $storyLength) {
                                Text("Courte").tag("Courte")
                                Text("Longue").tag("Longue")
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        Section("Choisir ton où tes personnages") {
                            TextField("Username", text: $username)
                            
                        }
                        Section("RÉSUMÉ DE L'HISTOIRE") {
                            TextField("Ecrire ici...", text: $storyResume)
                            
                        }
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Finalise et découvre l'histoire")
                        })
                        
                        
                        
                    }
                    
                   
                
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
                    
                }
                
            }
            
            
            
        }
    }
    
}

#Preview {
    CategorieView()
}
