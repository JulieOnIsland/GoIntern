//
//  RequestBuilder.swift
//  GoIntern
//
//  Created by Lee Juhyun on 4/15/25.
//

import Foundation

class RequestBuilder {
    private var apiKey: String = ""
    func buildRequest(prompt: String, url: URL?) -> URLRequest? {
        guard let apiUrl = url else { return nil }
        
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = [
            "model": "gpt-4.1-nano-2025-04-14",
            "messages": [
                ["role": "system", "content": "Generate a concise, professional, and polite LinkedIn connection request message under 200 bytes. The user will provide the recipient's name, where they met (e.g., job fair, conference), and a short personalized note. Use this information to write the connect message"],
                ["role": "user", "content": prompt],
            ],
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
            return nil
        }
        
        request.httpBody = jsonData
        return request
    }
}
