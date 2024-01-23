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
    @State private var generatedStory: String = ""
    @State private var isNextViewActive: Bool = false
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
                            generateStory()
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
            StoryScreen(story: $generatedStory)
        }
    }

    private func generateStory() {
        OpenAIManager.shared.generateStory(username: username, storyLength: storyLength, storyResume: storyResume) { result in
            switch result {
            case .success(let story):
                generatedStory = story
                isNextViewActive.toggle()
            case .failure(let error):
                print("Erreur de génération de l'histoire: \(error.localizedDescription)")
            }
        }
    }
}

struct CategorieView_Previews: PreviewProvider {
    static var previews: some View {
        CategorieView()
    }
}
