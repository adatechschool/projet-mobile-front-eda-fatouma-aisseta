//
//  CategorieView.swift
//  Projet Mobile
//
//  Created by Macbook Fatouma on 15/01/2024.
//

import SwiftUI

struct CategorieView: View {
    @State private var username: String = ""
    @State private var storyResume: String = ""
    @State private var storyLength: String = ""
    @State private var isNextViewActive: Bool = false
    @State private var generatedStory: OpenAIChatMessage? // Added for storing generated story
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(.systemBlue)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea(.all, edges: .all)

            VStack {
                NavigationView {
                    Form {
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

                        Button(action: {
                            guard !username.isEmpty, !storyResume.isEmpty, !storyLength.isEmpty else {
                                // Gérer le cas où des champs sont vides
                                return
                            }
                            
                            // Appeler la fonction de génération de manière asynchrone dans une Task
                            Task {
                                do {
                                    if let generatedStory = try await OpenAiService().generateStory(username: username, storyResume: storyResume, storyLength: storyLength) {
                                        // Afficher l'histoire générée dans StoryScreen
                                        self.isNextViewActive.toggle()
                                        self.generatedStory = generatedStory.choices.first?.message
                                    } else {
                                        // Gérer le cas où la génération a échoué
                                        print("Échec de la génération de l'histoire.")
                                    }
                                } catch {
                                    // Gérer les erreurs liées à l'appel asynchrone
                                    print("Erreur lors de la génération de l'histoire : \(error.localizedDescription)")
                                }
                            }
                        }) {
                            Text("Finalise et découvre l'histoire")
                        }
                    }
                    .navigationTitle("Personnalise ton histoire")
                    .navigationBarItems(leading: Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.backward")
                    })
                    .scrollContentBackground(.hidden)
                    .background(Gradient(colors: [.black, .brown, .black]).opacity(0.8))
                    .navigationTitle(Text("Personnalise ton histoire"))
                }
            }
        }
        .sheet(isPresented: $isNextViewActive) {
            StoryScreen(message: generatedStory)
        }
    }
}

struct CategorieView_Previews: PreviewProvider {
    static var previews: some View {
        CategorieView()
    }
}
