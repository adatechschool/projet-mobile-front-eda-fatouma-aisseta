//
//  ContentView.swift
//  Projet Mobile
//
//  Created by Aisséta Diawara on 09/01/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            ScrollView{
                ForEach(viewModel.messages.filter({$0.role != .system}), id: \.id) {message in
                messagesView(message: message)
                }
                
            }
            HStack{
                TextField("Enter a message...",text: $viewModel.currentInput)
                Button{
                    viewModel.sendMessage()
                } label: {
                    Text("Send")
                }
            }
        }
        .padding()
    }
    
    func messagesView(message: Message) -> some View {
        HStack{
            if message.role == .user { Spacer()}
            Text(message.content)
            if message.role == .assistant { Spacer()}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}































/*
struct ContentView: View {
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        VStack(alignment: .center) {
            TextField("Entrez un mot", text: $viewModel.inputText)
                .textFieldStyle(.roundedBorder)
                .font(.callout)
                .padding()
                .frame(maxWidth: 300)
                .cornerRadius(40)

            Button(action: {
                Task {
                    await viewModel.generateText()
                }
            }) {
                Text("Générer")
                    .padding()
                    .font(.headline)
                    .background(Color.gray)
                    .clipShape(Capsule())
                    .foregroundColor(.black)
            }

            Text("Résultat généré : \(viewModel.generatedText)")
                .padding()
                .font(.callout)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
*/
