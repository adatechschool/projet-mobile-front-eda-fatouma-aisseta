//
//  ContentViewModel.swift
//  Projet Mobile
//
//  Created by Aisséta Diawara on 12/01/2024.
//

import Foundation

extension ContentView {
    class ViewModel: ObservableObject {
        @Published var messages: [Message] = []
        
        @Published var currentInput: String = ""
        
        private let openAIService = OpenAiService()
        func sendMessage() {
            let newMessage = Message(id: UUID(), role: .user, content: currentInput)
            messages.append(newMessage)
            currentInput = ""
            
            Task{
                let response = await openAIService.sendMessages(messages: messages)
                guard let receivedOpenAIMessage = response?.choices.first?.message else {
                    print("Had no receive message")
                    return
                }
                let receivedMessage = Message(id: UUID(), role: receivedOpenAIMessage.role, content: receivedOpenAIMessage.content)
                await MainActor.run{
                    messages.append(receivedMessage)
                }
               
            }
        }
    }
}

struct Message: Decodable{
    let id: UUID
    let role: SenderRole
    let content: String
}

