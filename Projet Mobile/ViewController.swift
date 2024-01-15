//
//  ViewController.swift
//  Projet Mobile
//
//  Created by Aisséta Diawara on 10/01/2024.
//

import Foundation
import Combine
import Alamofire

class ViewModel: ObservableObject {
    private let apiKey = "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"

    @Published var inputText: String = ""
    @Published var generatedText: String = ""

    func generateText() async {
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters: [String: Any] = [
            
            "prompt": inputText,
            "max_tokens": 100,
            "temperature": 0.5
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)

        do {
            guard let url = request.url else {
                print("Invalid URL in request")
                return
            }

            print("Sending request to: \(url)")

            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Error: Invalid HTTP response")
                return
            }

            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
               let choices = json["choices"] as? [[String: Any]],
               let choice = choices.first,
               let text = choice["text"] as? String {
                print("Received text: \(text)")
                self.generatedText = text
            } else {
                print("Invalid response format")
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }


   

}



