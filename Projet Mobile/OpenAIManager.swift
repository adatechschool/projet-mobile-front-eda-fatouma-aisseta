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

    func generateStory(username: String, storyLength: String, storyResume: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        //requete HTTP
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            completion(.failure(NSError(domain: "Invalid API URL", code: 0, userInfo: nil)))
            return
        }

        //Corps de la requete
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(openaiApiKey)", forHTTPHeaderField: "Authorization")
       request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestBody: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [
                ["role": "system", "content": "You are an author who writes horror stories, you write your stories in french."],
                ["role": "user", "content": "\(username) is a character in a \(storyLength.lowercased()) story. The story is about \(storyResume)"]
            ],
            "max_tokens": 500,
          // "stop": ["\n"] //pour pas que ca coupe au milieu d'une phrase
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        } catch {
            completion(.failure(error))
            return
        }

        
        //envoie de la requete HTTP, On utilise URLSession pour envoyer la requête asynchrone et traiter la réponse.
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

            
            //traitement de la réponse conversion json -> dictionnaire swift
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                print("JSON Response: \(json ?? [:])")
                
                //gestion des erreurs
                //"choices" est la clé utilisée pour récupérer les différentes options de complétion générées par le modèle GPT-3 dans la réponse de l'API
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
