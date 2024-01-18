// HomePage.swift
// Projet Mobile
//
// Created by Macbook Fatouma on 15/01/2024.
import SwiftUI
import AVFoundation

struct LetterByLetterAnimation: View {
    let text: String
    @State private var animatedText: String = ""

    var body: some View {
        VStack {
            Text(animatedText)
                .font(.title)
                .padding()

            Spacer()
        }
        .onAppear {
            withAnimation(.linear(duration: 0.2)) {
                animatedText = ""
            }

            for (index, letter) in text.enumerated() {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.1) {
                    withAnimation(.linear(duration: 0.2)) {
                        animatedText.append(letter)
                    }
                }
            }
        }
    }
}

struct HomePage: View {
    @State private var player: AVAudioPlayer?
    @State private var selectedSound: String = "HorrorSound"
    @State private var isNextViewActive = false


    var body: some View {
        ZStack {
            Image("Home4")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            VStack {
                Spacer()
                LetterByLetterAnimation(text: "Découvrez l'horreur sur mesure. Plongez dans l'inconnu avec notre IA. Bienvenue dans une expérience horrifique et personnalisée...")
                    .padding(20)
                    .foregroundColor(.white)
                    .font(.system(size: 18))
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .italic()
                Button(action: {
                                    // Code pour passer à la prochaine vue
                                    self.isNextViewActive.toggle()
                                }) {
                                    Text("Commencez mon histoire")
                                        .foregroundColor(.white)
                                        .font(.headline)
                                        .padding()
                                        .background(Color.black)
                                        .cornerRadius(10)
                                }
                                .padding(.bottom, 50)
                                .sheet(isPresented: $isNextViewActive) {
                                CategorieView()
                                                }
            }
            .background(Color.black.opacity(0.20))
        }
        .onAppear {
            self.playSound()
        }
    }

    func playSound() {
        guard let soundURL = Bundle.main.url(forResource: selectedSound, withExtension: "mp3") else {
            print("Erreur: Impossible de trouver le fichier audio.")
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: soundURL)
            player?.play()
        } catch {
            print("Erreur: Impossible de charger et de jouer le son - \(error)")
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
