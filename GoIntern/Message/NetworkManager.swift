//
//  NetworkManager.swift
//  GoIntern
//
//  Created by Lee Juhyun on 4/15/25.
//

import Foundation

class NetworkManager {
    func sendRequest(_ request: URLRequest) async
    throws -> Data {
        let (responseData, _) = try await URLSession.shared.data(for: request)
        return responseData
    }
}
