//
//  AIResponse.swift
//  GoIntern
//
//  Created by Lee Juhyun on 4/15/25.
//

import Foundation

struct AIResponse: Decodable {
    let choices: [Choice]

    struct Choice: Decodable {
        let message: Message

        struct Message: Decodable {
            let role: String
            let content: String
        }
    }
}
