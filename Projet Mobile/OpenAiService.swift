//
//  OpenAiService.swift
//  Projet Mobile
//
//  Created by Aisséta Diawara on 12/01/2024.
//

import Foundation
import Alamofire

class OpenAiService {
    
    private let endpointURL = "https://api.openai.com/v1/chat/completions"
    
    func sendMessages(messages: [Message]) async -> OpenAIChatResponse? {
        
        let openAIMessages = messages.map({OpenAIChatMessage(role: $0.role, content: $0.content)})
        let body = OpenAiChatBody(model: "gpt-3.5-turbo", messages: openAIMessages)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Constants.OpenAIApiKey)"
        ]
        return try? await AF.request(endpointURL, method: .post, parameters: body, encoder: .json,headers: headers).serializingDecodable(OpenAIChatResponse.self).value
        
        
    }
}

struct OpenAiChatBody: Encodable {
    let model: String
    let messages: [OpenAIChatMessage]
    
}

struct OpenAIChatMessage: Codable {
    let role: SenderRole
    let content: String
}

enum SenderRole: String, Codable {
    case system
    case user
    case assistant
    
}

struct OpenAIChatResponse: Decodable {
    let choices: [OpenAIChatChoice]
    
}
struct OpenAIChatChoice: Decodable {
    let message: OpenAIChatMessage
}

