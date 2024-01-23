import Foundation
import Alamofire

class OpenAiService {
    
    private let endpointURL = "https://api.openai.com/v1/chat/completions"
    
    func sendMessages(messages: [OpenAIChatMessage]) async throws -> OpenAIChatResponse {
        let openAIMessages = messages.map({ OpenAIChatMessage(role: $0.role, content: $0.content) })
        let body = OpenAiChatBody(model: "gpt-3.5-turbo", messages: openAIMessages)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Constants.OpenAIApiKey)"
        ]
        
        do {
            let response = try await AF.request(endpointURL, method: .post, parameters: body, encoder: .json, headers: headers).responseDecodable(of: OpenAIChatResponse.self).get()
            return response
        } catch {
            throw error
        }
    }
    
    func generateStory(username: String, storyResume: String, storyLength: String) async throws -> OpenAIChatResponse {
        let userMessage = OpenAIChatMessage(role: .user, content: "Once upon a time, \(username) embarked on a journey. \(storyResume)")
        let systemMessage = OpenAIChatMessage(role: .system, content: "You are a character in a \(storyLength) story.")
        
        let messages = [systemMessage, userMessage]
        
        do {
            let response = try await sendMessages(messages: messages)
            return response
        } catch {
            throw error
        }
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
