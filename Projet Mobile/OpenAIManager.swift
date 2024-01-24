//
//  OpenAIManager.swift
//  Projet Mobile
//
//  Created by OZDEMIR Eda on 23/01/2024.
//

import Foundation

class OpenAIManager {
    static let shared = OpenAIManager()

    private let openaiApiKey: String

    private init() {
        self.openaiApiKey = Constants.OpenAIApiKey
    }

    func generateStory(username: String, storyLength: String, storyResume: String, genre: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            completion(.failure(NSError(domain: "Invalid API URL", code: 0, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(openaiApiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestBody: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [
                ["role": "system", "content": "You are an author who writes \(genre.lowercased()) scary bedtimes stories, you write your stories in french. "],
                ["role": "user", "content": "\(username) is a character in a \(storyLength.lowercased()) story. The story is about \(storyResume) and follow the chosen \(genre)"]
            ],
            "max_tokens": 500
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        } catch {
            completion(.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            guard let data = data else {
                print("Error: No data received")
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                print("JSON Response: \(json ?? [:])")

                if let choices = json?["choices"] as? [[String: Any]], let message = choices.first?["message"] as? [String: Any], let content = message["content"] as? String {
                    print("Generated Story: \(content)")
                    completion(.success(content))
                } else {
                    print("Error: Invalid response format")
                    completion(.failure(NSError(domain: "Invalid response format", code: 0, userInfo: nil)))
                }
            } catch {
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
