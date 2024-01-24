import SwiftUI
import AVFoundation

struct StoryScreen: View {
    @Binding var story: String
    @Environment(\.presentationMode) var presentationMode
    @State private var isCategorieViewPresented = false
    @State private var isSpeaking: Bool = false
    @State private var scrollOffset: CGFloat = 0
    private let speechSynthesizer = AVSpeechSynthesizer()

    var body: some View {
        NavigationStack {
            
        
            VStack {
             
                
                ScrollView {
                    Text(story)
                        .foregroundColor(.black)
                        .padding()
                        .background(GeometryReader {
                            Color.clear.preference(key: ViewOffsetKey.self,
                                                   value: -$0.frame(in: .named("scrollView")).origin.y)
                         
                        })
                
                }
                
           
                .onPreferenceChange(ViewOffsetKey.self) {
                    self.scrollOffset = $0
                }
                
                
                

                Button(action: {
                    toggleSpeech()
                }) {
                    Text(isSpeaking ? "Arrêter la lecture" : "Lire l'histoire")
                }
                
            }
            .navigationBarItems(trailing:
                Button(action: {
                    self.isCategorieViewPresented.toggle()
                }) {
                    Text("Nouvelle histoire")
                }
            )
            .onDisappear {
                // Arrêter la synthèse vocale lorsque l'écran disparaît
                speechSynthesizer.stopSpeaking(at: .immediate)
            }
            
            .sheet(isPresented: $isCategorieViewPresented) {
                CategorieView()
            }
            
        }
        
    }

    private func toggleSpeech() {
        if isSpeaking {
            speechSynthesizer.stopSpeaking(at: .immediate)
        } else {
            speakStory()
        }

        isSpeaking.toggle()
    }

    private func speakStory() {
        guard !story.isEmpty else {
            return
        }

        let speechUtterance = AVSpeechUtterance(string: story)
        
        // Choisir une voix mystérieuse (adjustVoice() est une fonction fictive)
        speechUtterance.voice = adjustVoice(for: "MysteriousVoice")
        
        
        speechSynthesizer.speak(speechUtterance)
    }

    // Fonction fictive pour ajuster la voix
    private func adjustVoice(for voiceType: String) -> AVSpeechSynthesisVoice? {
        // Récupérer la liste des voix disponibles
        let voices = AVSpeechSynthesisVoice.speechVoices()
        
        // Trouver la voix correspondant au type spécifié
        let mysteriousVoice = voices.first { voice in
            return voice.identifier.contains(voiceType)
        }
        
        return mysteriousVoice
    }
    

    
}



struct StoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        StoryScreen(story: .constant("Ceci est une histoire générée"))
    }
}

struct ViewOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
