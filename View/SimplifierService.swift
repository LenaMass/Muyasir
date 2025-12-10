//
//  SimplifierService.swift
//
//  Created by Shahad Alharbi on 11/27/25.
//

import Foundation


struct SimplifierResponse: Decodable {
    let simplified: String
}

enum SimplifierError: Error {
    case invalidURL
    case invalidResponse
}


final class SimplifierService {
    static let shared = SimplifierService()
    private init() {}
    
    private let endpoint = "https://muyasir-backend.onrender.com/simplify"

    func simplify(text: String) async throws -> String {
        guard let url = URL(string: endpoint) else {
            throw SimplifierError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = ["text": text]
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let http = response as? HTTPURLResponse,
              200..<300 ~= http.statusCode else {
            throw SimplifierError.invalidResponse
        }
        
        let decoded = try JSONDecoder().decode(SimplifierResponse.self, from: data)
        return decoded.simplified
    }
}
